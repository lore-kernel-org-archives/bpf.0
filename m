Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231255;
	b=X3tqc4hCWL0Q0sE45/clWWN92xbwWFfQfRH5rXMoR9+WuzBQ2qOe2wXzNLXblWGPz5iD
	 rt9QmNBgBy1OOpopO6qg7ADXqAKPF/itfFfVKR7CWHo6xql2CXK7gRFzeZSzekuT2TPa/
	 6zS9NxMZNhnB9n9C7lp8QCOicDj3CB4ptbaQQT96g9MWIJIx8H1A9mhu9KKuMLjI07NtB
	 +YOpwt+Hh91g3Iq7pe3RSWpbmsKK25p5YDozA4+2n/18FhC89HQQqDKZnALAKr3guxtxO
	 b8CrUh93on2VDW42ppTfck3OuMvcjPsMNESz+ePpKAU0ubLcet0kfDLy8ZLjv73KPCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231255;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=O/zXdtBfMr7yE0U9APEwE8s+KVBal7Su8WTATDna9Ng=;
	b=plvMiDcSETNAnCvwOHuXHJxsJCgqLmCvozlgHLPDLOJHXjTX3+MwhItuoMMpor8dS2ZV
	 IltQvVoR9GN4krZKrNrngjYdK+hT6PlBvllLcTa6ps1sfnL2PGEzyU+9V8xpxqax3S8Kz
	 /DJsfNaCAY4rjdH0d8jGREdtAnx79JqV6tgC80UKYg4IuiIAZwX5ThLjDgkjJT0FmufuK
	 3AyyQEDqjFfybxQbh6Dulc136WThC36TaHUdVmw3cN76gIsyaMrfL3kDGH0SM0njwYVT2
	 cEHTjXG2ZGAAnQLE66Xyk55xKVvvNY81CiS/2zfkJ5/FYYluSZvUcFAynqNJNgosL/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t6WN2+mE;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22842606A321
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 13:34:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22842606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t6WN2+mE
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-491971ac844so845916f8f.2
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 05:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794231253; x=1794836053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O/zXdtBfMr7yE0U9APEwE8s+KVBal7Su8WTATDna9Ng=;
        b=t6WN2+mE9iQM4YnBdje3Ui5tG4kcd7+vF1GCKhcKKS+jODZ9yiCDlIOBXOXG0kq4cB
         PzdFGYUKQ4k4L+90G2rnighEFZqpX78LhMdzuj1UXh+zG9nSZB3Rml3K1+KW1d2Adt8r
         t7I4BBpU+X8qovz9enet/RDJidp26NSFkRTsw5vrcG1IrIsqG93SIJJZl5SQusybotXh
         CceBgspQ/Bxt2yZ9R90xLj4i69rFkyMqHsU8hecMk5QgBX/iXv3iuBejQZFnwn70mxQp
         pE2DSaDMJXmAqjUJG2/s1HSO5UIv6r6PEqKI7D637XAieA7X/9ivuyvsMiNqicEMznJa
         mzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794231253; x=1794836053;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O/zXdtBfMr7yE0U9APEwE8s+KVBal7Su8WTATDna9Ng=;
        b=PhWxtLOb12rlzm3DaOy/31eBBE1+igSlyawhIaCYndsGRtJ1MBucQiIRoEGV01LSbB
         8ZBGejQUVj2I0ltcPqV6+YEWihkGvoj1pbCODLnZwvEdc8SG11OBQeJQCcgqGI4imSKt
         65L+A1CLmIyaQeGdhLOHWeQWi7tUdrtCRjx66tzET5uyRDbj98lW7hNHYbgx/ZF7EKFL
         MBxudi/3KVyZ2PMlU3PcZWtI5saS7QhB1sFurPF74CQM+21Zk++r3njDnWy7DukoLY9i
         FOXvmITgMQxJ+byryWsW/AsXznwdrL1le7r2f5Qphw/zIKyBB+98x3vn3nZx/PEuZQri
         CyWg==
X-Forwarded-Encrypted: i=1; AL+hErErKKaynMKB0q6mamwx9az03OYNAdhEw+RVXzkJGkgpXvy8NDdskltGwjXGmvK9iLZJHms=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ty57u4b6y4s/49HX5i4y2gv07jIj6PHPuYd7Kr8TWHO6Dg3Ik
	LTK8Kmr5vEboL0p02OhanSKmJZIuscKDxr+dgJkBR6+eu3xlAZtOcvdM
X-Gm-Gg: AYBFou0kwplVqskPqtTuMAoSrXeXRux2iFqCD3t0+due2nhEaMG27rlroH02y0JTM3j
	PwsQ8ZP9vXeWke+nVc+gye9ZZrmqoUw2KCscHXx5HuomszHZGXntsfgEhI86F1c5dIza/U4rmy0
	ZHo+ZUQSvwmR0r5HggJYLHBkrtPGpC1pdbLvBCUkrSQIV1MtuOIuHcriBZHG4Ip1gezmDSOEJuv
	gT/ZWPlLhFHy6h9SZ8iNtU0mrzN7/QqWrMyTNnaC4Oq+wfE1RKKFbqXPuD4zQ1GupdcbcqIZ5u1
	6x9g2BvOGSR2wv2282BKON3kCwNBcN1qVMQZ+OdABSaSQ+1+gHYqBp5QDLozHUaK/QivHdiWhA7
	oLFUvVWZ9VNETFyZnqrGNUKMLXF8xcGODfrZilOeip5cRSmbF9481q7/UkguUpV72bSOY+6IQ18
	/QIaQVEZbqVqgcfKj7nvmzhKfQVtpJctLpAZYbqbLthxTF69EOnLtgLQVPJuztopHNFnYwVGiZC
	Q6oCRZb+pi+45Eaw0G8BLQK0urGdWnHgTMK2T8k85QZeUfvWfqWD9n1dNwP5df3LrgXKMwbx1B+
	PAkBW3inGYSuApP5y0EhO1v3W3I5Pqc2kJfZrbQbnrq5Zj1vEwZaLHc4TQ==
X-Received: by 2002:a05:6000:26c8:b0:494:f239:aefa with SMTP id ffacd0b85a97d-49584d47551mr8921475f8f.34.1794231253290;
        Mon, 09 Nov 2026 05:34:13 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-495966f3163sm10075884f8f.11.2026.11.09.05.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 05:34:12 -0800 (PST)
Date: Mon, 9 Nov 2026 13:45:46 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com, almagui@kernel.org,
	john.fastabend@gmail.com, qmo@kernel.org, brauner@kernel.org,
	kpsingh@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
	emil@etsalapatis.com, ihor.solodrai@linux.dev, sashal@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	martin.lau@kernel.org, mason@kernel.org
Subject: Re: [PATCH v1 bpf-next 17/18] selftests/bpf: Enable bpf_scan_ir in
 the config
Message-ID: <avHOikbXvM5poRr5@mail.gmail.com>
References: <20261106210314.1767267-17-a.s.protopopov@gmail.com>
 <23cbf06b46fa6d1cdfa3a9bbcd247deec22de8efbe5d1b2fff4cb89177171d56@mail.kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23cbf06b46fa6d1cdfa3a9bbcd247deec22de8efbe5d1b2fff4cb89177171d56@mail.kernel.org>

On 26/11/06 09:35PM, bot+bpf-ci@kernel.org wrote:
> > selftests/bpf: Enable bpf_scan_ir in the config
> 
> TL;DR: Commit message only: the list of cases where Kconfig ignores the plugin
> options looks incomplete (other arches, missing matching llvm-config), so "CI
> builds and tests it" may not hold and fmodret_retval may silently skip.
> 
> >     selftests/bpf: Enable bpf_scan_ir in the config
> >
> >     The bpf_scan_ir plugin is off by default. Without it bpf_testmod has no
> >     fixtures for the plugin and fmodret_retval skips. Enable the plugin in
> >     the selftests config, so CI builds and tests it. Kconfig ignores the
> >     options with GCC and with clang older than 19.
> >     Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> 
> Is the list of conditions in the last sentence complete?  The commit message
> says Kconfig ignores the options "with GCC and with clang older than 19", and
> that CI "builds and tests it".
> 
> scripts/llvm-plugins/Kconfig has more conditions.  LLVM_PLUGINS needs
> CC_IS_CLANG, a working $(LLVM_CONFIG), an llvm-config with the same major
> version as $(CC), and a $(HOSTCXX) that accepts the LLVM headers.
> CLANG_PLUGIN_BPF_SCAN_IR needs X86_64 || ARM64, DEBUG_INFO_BTF, !LTO_CLANG and
> CLANG_VERSION >= 190000.
> 
> So config.s390x, config.ppc64el and config.riscv64 never get the plugin, and a
> clang >= 19 host without a matching llvm-dev drops both options silently.  In
> those cases the build succeeds, bpf_testmod is built without the
> bpf_testmod_retval*.o objects, and fmodret_retval reports SKIP.
> 
> Could the message list the full set of conditions, or say that "CI builds and
> tests it" only holds when a matching llvm-config is available?

Yes, thanks, will rephrase it.

> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42294987431

