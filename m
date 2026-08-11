Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB1621D5B0
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 01:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786411481; cv=none; b=UBww2ZzQhz3ecnB+E41wAlwX6ePb6qlYA65cKYwrDxEyzAFpnYMxn+0427q5C0m5lSlSMN6TfxSgFs3gqKPUsnC8oYsOk9L5z2A2qpuC1fxN8iTDztMmbiYZ1x6/tq2JHgd2zQkJoDX9p2JRuxrjoJG4w4I66YdZb+NHg4IBw0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786411481; c=relaxed/simple;
	bh=4EzcKJxqaISsKrjraFrqqvs3fJpySessv73uF+2tRVI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ia70eNboapjrtS8Z9koFd6i3pAfhxTDa5Bvspg7/jGYF/6SnQg2rL0S1B9qVqLJoNzEeuqQoc/PCiyuP4eFCKsPyfA/iRfUfBKFIOI4ntY+LkiHN2F0soIL5enZzCIBP/j7H9ZweNJjasKiGRcuA5oIPsh3K76u2JTFf8lrEqTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdsOs6uS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdsOs6uS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433581F000E9;
	Tue, 11 Aug 2026 01:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786411479;
	bh=NMEY7gNkAG7APCyPNKXDRpSVsjRL/Yllr+m3RSjQL44=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mdsOs6uSXFbh2REu2UafUeHuXdSlHBYv5NegS5kg1vna6NE+ZcRN4YGQxbEXsg5TA
	 MtcMeze5DsXl2oyPV/FCSv4SnkYDMcMc6cBepBXVrp3AUNg41OWMsjB55ue83CqV1x
	 oK2qbqCCFlGrWigTQ6daXMAW2+mSCdcAe6Kl2Hfi7TUJ7dnznPlZsUyIZW0BzDEHcs
	 tzDe46kWLTZ9G4MVP0iLlGw7STqcbhTdi0ASFtItsW6YecZQbF5PDHzbBGgqIgtd78
	 BrZTrGYNszcwPdHA8k7K+GoWNTdin7V8prERB2wxVmaAbtwQ6aElTrQFXwCKTNm7fc
	 4RI5kLpHOcbTA==
Content-Type: multipart/mixed; boundary="===============8655283796113892296=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6f2c9aec3d0d31790b496528dd26ad54304e4a4edefaa845306a79cd4d029e01@mail.kernel.org>
In-Reply-To: <20260811000922.2380171-1-yonghong.song@linux.dev>
References: <20260811000922.2380171-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v4 02/13] bpf: Add helpers to describe the R0:R2 return register pair
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 11 Aug 2026 01:24:39 +0000 (UTC)

--===============8655283796113892296==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>    - subprog_ret_type() resolves a subprogram's BTF return type. It is
>      factored out of subprog_returns_void(). The verifier_bug_if(!func) and
>      !func_proto checks it replaces are redundant, since
>      check_btf_func_early() already rejects a func_info record whose type_id
>      is not a BTF_KIND_FUNC pointing at a BTF_KIND_FUNC_PROTO.

Is check_btf_func_early() the correct function name here?  Running
`git grep check_btf_func_early` at this commit returns nothing, and the
validation the changelog describes lives in prepare_btf_func()
(kernel/bpf/check_btf.c:31):

    /* check type_id */
    type = btf_type_by_id(btf, krecord[i].type_id);
    if (!type || !btf_type_is_func(type)) { ... goto err_free; }
    func_proto = btf_type_by_id(btf, type->type);
    if (unlikely(!func_proto || !btf_type_is_func_proto(func_proto)))
            goto err_free;

The in-code comment added by the same hunk already uses the correct
name: "Both already validated by prepare_btf_func() at prog load."


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31446101762
--===============8655283796113892296==--
