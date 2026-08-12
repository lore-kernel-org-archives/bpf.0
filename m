Received: from mta0.migadu.com (out-113.mta0.migadu.com [91.218.175.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FBD2EEE88
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 19:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786563129; cv=none; b=GQgaD1nxy23V1cdIUPcuw1hMgU5Ce8U/sfojT0Hnd25+QrFGJ2KzzyXSCPNBeN9qgnbaFcWhT5EBEb7t1+jDXVMRb709ITKMn0dZ+FtLUUfsn/xHpbyRW2BPmh3PR3KfuTUWC0bg9N4QizIPHVHZ8uwX4eIcphom8t7CbBIc76w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786563129; c=relaxed/simple;
	bh=s3vvrzew3JXcCb25KvaEK46N/OPYPFMbfC/KNGiPs9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jeMd+bfF2fs1L1SLdMK1JJmTY2i4nqFz8zKNwJIYxPE3t6pT8yT/Eggl1UNLYMZJ+lzDGTTj319MqKEJr+gYBzHwJsaJyuxjDpgZOXsV8EqEpf3W4p6i/6SFE46tkhp3llFbhtaZZlVTIeBBNK/nZUcdm4sh4f69ZeF/ATzEL0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=thvCp3hR; arc=none smtp.client-ip=91.218.175.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="thvCp3hR"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=s3vvrzew3JXcCb25KvaEK46N/OPYPFMbfC/KNGiPs9g=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786563124; v=1; x=1787167924;
 b=thvCp3hRGfkA5Hy9p6LiPvX2CENODodC5qCLC5357vSfxsc4pPep3kqzIh0R+TM9GU/Lbu+K
 7lKDpmDX2mykbG0qpncV4x+TDXz+YjG5BhMLAi0gqI0GjezrOjYmqxZd8UNLQEr5U3o3We7nSPg
 z9tVxqRSrA+Hw8zGwCwoGuws=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2a03:83e0:1151:15:1c5e:37e8:36:dd37] (2620:10d:c090:500::7:cd95)
	by smtp.migadu.com with ESMTPS id f2d72fb8c181d42f;
	Wed, 12 Aug 2026 19:32:04 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <a26a2e3d-258d-4f76-902e-908a0bbad3e4@linux.dev>
Date: Wed, 12 Aug 2026 12:31:56 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 02/13] bpf: Add helpers to describe the R0:R2
 return register pair
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260811000922.2380171-1-yonghong.song@linux.dev>
 <6f2c9aec3d0d31790b496528dd26ad54304e4a4edefaa845306a79cd4d029e01@mail.kernel.org>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <6f2c9aec3d0d31790b496528dd26ad54304e4a4edefaa845306a79cd4d029e01@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/10/26 6:24 PM, bot+bpf-ci@kernel.org wrote:
>>     - subprog_ret_type() resolves a subprogram's BTF return type. It is
>>       factored out of subprog_returns_void(). The verifier_bug_if(!func) and
>>       !func_proto checks it replaces are redundant, since
>>       check_btf_func_early() already rejects a func_info record whose type_id
>>       is not a BTF_KIND_FUNC pointing at a BTF_KIND_FUNC_PROTO.
> Is check_btf_func_early() the correct function name here?  Running
> `git grep check_btf_func_early` at this commit returns nothing, and the
> validation the changelog describes lives in prepare_btf_func()
> (kernel/bpf/check_btf.c:31):
>
>      /* check type_id */
>      type = btf_type_by_id(btf, krecord[i].type_id);
>      if (!type || !btf_type_is_func(type)) { ... goto err_free; }
>      func_proto = btf_type_by_id(btf, type->type);
>      if (unlikely(!func_proto || !btf_type_is_func_proto(func_proto)))
>              goto err_free;
>
> The in-code comment added by the same hunk already uses the correct
> name: "Both already validated by prepare_btf_func() at prog load."

Okay, replaced check_btf_func_early() with prepare_btf_func()
in the commit message.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31446101762

