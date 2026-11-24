Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.206
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795487326;
	b=470jD7JzT1jwZVt/614klV9JbB2psBPjIeJ4eDaxZ05wBVwNdXqKyQdmWfy64h+UhZK8
	 TtgwqcvpijALNCL0M6w78qj1Zfbhe1g1VC3ulk6KYxCmX7hUyQvVvPVLbks0jjLWPsgqO
	 DGNsbU1wuHDmRcSHVIMgAUOelFSbD3I/FbGKv/8LEP8YjtseT0tujFeAOWlSjqwUVwoD4
	 UMBbjgHYAuDcflqUUaPI/wrGNa9cp2PoZOEO1HI6zeK/bLsempC9Mlsdnw3ZrPfkWjQ0/
	 GWyK3Vvvij6tesyPLopJoThK0sWT/EGFZs8/w2FoPpjlGuHTscXMtLTooZZW8F8EWJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795487326;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=jWQ9oCUe8dQcy4ZXx1Lvb8FfXfIF5K4CXki6DLWYMDE=;
	b=Vub2oHGhm99xHTALFVHeJc+q1E5QjdV2Gt218MmEcLOQlfC+FhiaflHQdqJuR9CaCLL/
	 AkaDvRXWYN0xUP8ndX5A5wlkduESgi2hM6z+eyLVQlrtTtUzmIWsCtAoY01CU/lKJINJO
	 Fcc6SwVqmFhpWaezhRIa9suyexDHbKkwrTi+apSxs6gJnmNJKwY4KVtoyAYm6udu10+ju
	 KY1J4Q74mNGh9Zxhn7Ys5PPaxGSKzIooMJ5LkW3BiaSjqsAASxWgEDO1vXQPSjtVuoIw5
	 /oN9CmhvurxAq0PRAKt/nj1qqJBL2DSjyWBD+K5PDlIybLLcxdRr3ZFU6hL19CFchew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="QBxdv/hD";
	arc=none smtp.remote-ip=91.218.175.206
Received: from mta0.migadu.com (out-206.mta0.migadu.com [91.218.175.206])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D929606A321
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 02:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D929606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QBxdv/hD
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=rbAkWnSYTM9mjjasFPW8Smsf+DAoZjkmvAVq1CXIXUI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795487323; v=1; x=1796092123;
 b=QBxdv/hDlru2pgV2e5cV48O9iRFiG6YsDHYSeNc5t/Aq1/KEyxsd4rkstoGtHPVhGzrlaJPF
 swo3YEewm4r53D48Jo3TmK+fuJv/GaI1R+V9F57m/CLL63LrdO8H+Jwg1zXKJDg6tL3DWW+BVu9
 qbWOygz7CBgfBAg+o2AgQMmw=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4c2eda220562a159;
	Tue, 24 Nov 2026 02:28:43 +0000
X-Mizu-Trace-ID: 4c2eda220562a159
X-Migadu-Flow: FLOW_OUT
Message-ID: <7c51f0df-461a-463c-afff-16644f65c107@linux.dev>
Date: Mon, 23 Nov 2026 18:28:39 -0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/2] kbuild, bpf: Remove pahole version checks
 below v1.24
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20261123231058.2538362-1-yonghong.song@linux.dev>
 <dc257c60f91ba87c244a6bf9a9d7b424adfd17629c6926085c87cd2188772df3@mail.kernel.org>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <dc257c60f91ba87c244a6bf9a9d7b424adfd17629c6926085c87cd2188772df3@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/23/26 3:41 PM, bot+bpf-ci@kernel.org wrote:
>> kbuild, bpf: Remove pahole version checks below v1.24
> TL;DR: Commit message only: claiming the resulting config is unchanged looks
> inaccurate, since PAHOLE_HAS_BTF_TAG becomes y for clang builds without BTF,
> though with no functional effect today.
>
>> kbuild, bpf: Remove pahole version checks below v1.24
>>
>> The previous patch makes CONFIG_DEBUG_INFO_BTF require pahole v1.24, so
>> the Kconfig checks for an older pahole always pass with
>> CONFIG_DEBUG_INFO_BTF.
>> Remove CONFIG_PAHOLE_HAS_LANG_EXCLUDE (pahole v1.24), which is always
>> set with CONFIG_DEBUG_INFO_BTF. Drop it from the dependency of
>> CONFIG_RUST on !CONFIG_DEBUG_INFO_BTF, and always pass
>> --lang_exclude=rust in scripts/Makefile.btf, which is only included
>> with CONFIG_DEBUG_INFO_BTF.
>> CONFIG_PAHOLE_HAS_BTF_TAG (pahole v1.23) is still needed, since
>> btf_type_tag is only used with clang, but it no longer needs the pahole
>> version. Every user of it also checks CONFIG_DEBUG_INFO_BTF, so make it
>> depend on CONFIG_CC_IS_CLANG only.
>> The pahole flags and the resulting config are unchanged, except that
>> CONFIG_PAHOLE_HAS_LANG_EXCLUDE is gone.
> Is the last sentence of the commit message accurate?
>
> The new definition changes the resulting config for clang builds without
> BTF:
>
>      Before:
>      config PAHOLE_HAS_BTF_TAG
>          def_bool PAHOLE_VERSION >= 123
>          depends on CC_IS_CLANG
>
>      After:
>      config PAHOLE_HAS_BTF_TAG
>          def_bool CC_IS_CLANG
>
> With LLVM=1 and pahole missing or older than v1.23, PAHOLE_VERSION is
> below 123, so PAHOLE_HAS_BTF_TAG was n before.  Now it is y, and
> CONFIG_PAHOLE_HAS_BTF_TAG=y is written to .config and the generated
> autoconf.h and rustc_cfg even though CONFIG_DEBUG_INFO_BTF is n.
>
> This has no functional effect today, since both users (compiler_types.h
> and trace_event_update_with_eval_map()) also test CONFIG_DEBUG_INFO_BTF.
>
> Would it be better to use "def_bool DEBUG_INFO_BTF && CC_IS_CLANG" so the
> generated config stays identical, or to reword the commit message to say
> that CONFIG_PAHOLE_HAS_BTF_TAG is now also set in clang configurations
> without BTF?

Okay, since CONFIG_DEBUG_INFO_BTF is not involved with PAHOLE_HAS_BTF_TAG,
I will leave it as is in the next revision.

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45289030741

