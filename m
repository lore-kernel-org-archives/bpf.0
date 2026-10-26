Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793046699;
	b=fUhTeHDw5vUpwPWVS9i0BQu1YcNk0BGG/ghTI73R49usS9L9E3BijVmrtZbcD6+Whbwk
	 slTyhiVXeI9C5mhOUGCm3lfJ1RG7OgNo8RyxhWS+R80M7PqDc4wMq7FDob6QA7WV4l81l
	 lRMqu/hy4wI8AQMMlEU1nzU5jJqRq2RkHQ5iuoMCVBgMBB/qDHLm+HG/P0/XGT5xOxKWD
	 si9SMaosJSHB3prnUsK7mRwTfuEiCYkEorjiqzSj1rHOFbqMJs/7ixLsH/VCmulOc1PVX
	 ReFjha+SGufO7NHGzsHEQ0Jdkdk7cEwduX0GSRRYu5ch3Eg9Fn2OC4UizhRtYnXpCvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793046699;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oLlOcSCQ32pMuVJGiKdjmwfrqV55t/QVJ+mNxxfwt1w=;
	b=aXPKpSi0ykGm/2UxbWdTqO1cY2yCcorgqRWqNEdeZFU1W6HYSsWRBJOLV9bR/ZwrwYpO
	 O3UIO//RngRSW1KjSIA2g3ypSADdXwpinArfmBPIYXfYKy2acxROqJ9kXz4afRDwLcHh5
	 b4kvHznaUbJ1hngXu+DXc83J6vJKM9oZaMaYOBZtuISDLFYgLZ3bANkkJM9fBlYlrrggH
	 RVq0HU1rXglmcOv12lqXB0LkUoK+AyUKZBANzlCO+l7ab7bq4NCnsrlHx5ib+XnCUR1SU
	 D0KjDJGDSrEqBK+eG7V5UselFmdUVFxp2dE63ZqH/b6uW8J+qrBVFOdPAPSBgaTg+xA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=L+wootqW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABDD606A31D
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 20:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9ABDD606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=L+wootqW
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e9995ce866so31806165ad.0
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 13:31:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793046698; cv=none;
        d=google.com; s=arc-20260327;
        b=WCggMXudwmdCHt2NYQx0EwLkeEXPyqGCYZvPCBr46fDcb4lgECDYJNMsP+q+AjCSR3
         XOo1cJpl3Qk/RKhKiO13/YssWgb++e2OmCLGbarMnWiMnCQuay5GKZvDeZnUKA4HhAM0
         rtFsvetaXjwlPhhAUCRgU/pQjCqyQFkdHFC94R2NyXI3hc1docM++dkhtFXvlBa2mzsF
         oIoRu8ZIlW+pt2uFtt9n2WpogryFOe1qIMvSx8ImzFL91uF+M9UwTVvyAdAHSt5wmm6i
         V2859No9dl1zgjr4xeV3Ll8MpbdoLAAtLTFNyq0sNv0MxZyCb25z9soIbOAzPdic0uaU
         XFYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oLlOcSCQ32pMuVJGiKdjmwfrqV55t/QVJ+mNxxfwt1w=;
        fh=Wm5L619v7n3PFgr0cxgKi+7JwabOEyLv9wXgxydqiNM=;
        b=cPwJlm8E2uOKvG31oyRu2ApKPZeCfryR3VTIs1hFVS3C1qCj4MdBS5wIMMkE86BZEj
         QWoVBFccqxkXA99nodCmM2wFwlzzxJtK2yhQWbUbD17B/rRxKd+/EWE2gZrxBygvrLpj
         W4XE0JrxCATfRDLc1jbVn/Uh7u8QdL0K7GzW098ptUiCK13EWjyryuDFRPPmV9Wg9jKc
         /7tqxqY3WIE3jDBb+ls07D9JNLqa9s/LQdnyqlff/29nWyYPHpTFkwQp3Gn1WP8tGDTs
         Kwv5jpTb5bzTMDgabQ3RYbTQCqCUXZHRkyfGXOA48SvZ2YhkUnd3Q9vtg+tTWGU2uhIr
         jkqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793046698; x=1793651498; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oLlOcSCQ32pMuVJGiKdjmwfrqV55t/QVJ+mNxxfwt1w=;
        b=L+wootqW5T77UGOryyw3TrOnPRmPjLL2i4uoI36Fb52hAChavbUjC2oAErcwcWcJq1
         gwgn++rWkrUiN4eZmtVkxuIBOAsAZefl8wqr6EQCDZZBTjk1hO2UkuEyI8i5m5RjX7DJ
         EK1ndGeANRMX4aTbpO+nvR7fIU63VxFQ9ffp4FXCojFjYD+fdWAL9RHBV9A1L4pnrwWe
         CwArxDWTNOmGZ0DS0oKM86YGqSE9zdjWjrY330iiwsDo23ENOID23IQ7tNUIGTMjbHgT
         BUbvwez+Hzl4lCCb8TSHKJZNqHNNnbu8YjtxV98iTts8xUYoVruc0kCp8wqVv0S6jf5w
         /EUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793046698; x=1793651498;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oLlOcSCQ32pMuVJGiKdjmwfrqV55t/QVJ+mNxxfwt1w=;
        b=iyswZlvXpKewUuOCRVmm7EhIlhRdMeGXhsh59Ax7FlK5DhY7cwsPCfLzlIie29XsV/
         NV3buM988APpmiYTJ1nM516pdXAyDNRo7tes+GnbHeBzkTMk03e+9TBR2apxl95P+DPD
         C2Jc7lj7Wa53uvXVntEeIOYaMhoBxTV0or65t8VUTH+tBCZWoho8GHXkhiza0i0VFexU
         wf9OO6t1+U1H9QcBeFdbH/9Q6CmbCWrBvJWS2UNdAKMEPFuKVcdIIAAZ8kQzqXgTGncv
         7v8pkQF/Oe7toBU4zbQnSdsYCpS3LKBg9r/XF/zRiMgeb5rkT4Smly8ysbn5h77OBn+x
         0aAQ==
X-Forwarded-Encrypted: i=1; AKwUvByO5VYT2dmByGybFxGX+pLKaZ+PdQLdsxRS3NviLvL8DUtbGPKz4h+4w+dk4ogJIKOWJOw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIiCPn2Qqh+tA+dd+zFMikitE/u37vE4S/Ckwa8nOoHxRhT7QFJ
	fDQ84boXSp4d3qxeOeogYSNhsQ8ej5rS1RbpLoNcDIn5UhscoHNeuVEE1yczjMz7BJC0gfrW+q2
	RMKxDUkROiFM26yEKTMZISsd/Kl12pT7Y7scRRMdh
X-Gm-Gg: AYBFou0SPzhzd/sf4rNkg0slg9PiwRZo9kJyXx3q+m+Ub3x8fzJcnqjWdv5PKWdRkKG
	Dh4mhCqnvO1qdU1RYA1bngWKqyhBBNRGwtwT3OTg53WrC/yqrEqZthM+A00IbYKEisbcAgWXlbi
	18hFybJ2rISLvLQrAbqhY4aK/5IFDVDs38XvKuIWmn5f7Bo/nzr1xVJaRYLoD2kDC24Mu17wzXK
	cerC3MYjDCawoBpRsgKEMdVce/CLMKCaAcJkdiOvyWL5aiYqlZ8Gwe5mhyTxhwRJZQf67vuot70
	msEqAO/wz7g3E4dBBTNqxPZpHruhcu06zES58i3gMUz+jfxc2Z1gGDfg39aoyFXMNebkl5DnUUF
	aehIKDPEx00dQccC9IiwO0hmH1myAqxx9ynY5D7/X+In1ATR4ibZuDr/9Uwr5/qw5uY9FFL0kJv
	1hTHz4kKVdI1E/Xg==
X-Received: by 2002:a17:902:ecd2:b0:2e8:30dd:523d with SMTP id
 d9443c01a7336-2ea9c620609mr71569325ad.13.1793046697876; Mon, 26 Oct 2026
 13:31:37 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org>
In-Reply-To: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 26 Oct 2026 16:31:25 -0400
X-Gm-Features: AclHuK_MBYtdpmV00LiIGiHwgdDyciJ8YZFfqnRLK0ynU1qoZWOLvejR9vdc3xM
Message-ID: <CAHC9VhR4rMydWiD-RFv-ABiYSG_txJuyrtdaowEXPY=CHEvFXA@mail.gmail.com>
Subject: Re: [PATCH 0/8] ns: fixes for the namespace LSM hooks
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 5:57=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> I tried to switch systemd-nsresourced over to the namespace_free LSM
> hook that went in this cycle. I explicitly developed it to work nicely
> with that. But the version that is merged is broken for that case.
>
> The namespace_free hook is never called. security_namespace_free() bails
> if ns->ns_security is NULL and that's only allocated if an LSM requests
> a namespace blob. Nobody does. Landlock doesn't care as it only uses
> namespace_init and namespace_install but a bpf program attached to
> namespace_free never runs. And it can't work around that either. We
> could make the bpf LSM request a blob but that would just be a way to
> make the hook fire. So call it unconditionally like we do for
> superblocks, files and bpf maps.
>
> The bpf LSM also marks the arguments of namespace_init and
> namespace_free as trusted. Curiously that patch was also dropped.
>
> namespace_init is called before the namespace is set up and if anything
> fails afterwards the namespace is freed without looking at its reference
> count. namespace_free is called on the way out. There's no kfunc that
> takes a namespace yet but once there is one a program could take a
> reference to a namespace that's about to be freed. So add both hooks to
> untrusted_lsm_hooks.
>
> The namespace_init hook also always sees a namespace id of zero because
> the id is only allocated after the hook has run. The id is the only
> identifier of a namespace that is never recycled. So it's what a bpf LSM
> wants to use to track a namespace from namespace_init until
> namespace_free.
>
> The inode number is recycled way too quickly for that. So allocate the
> id in __ns_common_init() before the hook is called. Then ns_tree_add()
> doesn't need to allocate ids anymore and ns_tree_add_raw() can go.
> Landlock keeps logging zero for denied namespace creation because that's
> what it documents.
>
> I'd want to get the first three patches into v7.4 since the hooks are
> new this cycle. The systemd change I have for this uses the
> namespace_free hook whenever the kernel has it. On a kernel with the
> hook but without the first fix it would never learn about dead user
> namespaces.

From what I'm reading the LSM framework patches don't meet the typical
LSM criteria for stable/RC fixes: there is no serious bug/panic, and
there is no functional regression from a previous release.  It also
appears that the existing Landlock namespace code still works as
expected.  This looks like one of those unfortunate circumstances
where a new use case wasn't tested thoroughly enough before the merge
window, so it can wait for the next one.  We've already identified
other LSM/namespace issues that are targeting Linux v7.5, the
security_namespace_free() change is one of those as far as I'm
concerned.

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> Christian Brauner (8):
>       lsm: always call the namespace_free hook
>       bpf: don't mark namespace_init and namespace_free arguments as trus=
ted
>       selftests/bpf: add verifier tests for the namespace LSM hooks
>       landlock: pass the namespace id to log to check_ns_type()
>       ns: allocate the namespace id before the namespace_init hook
>       nstree: drop ns_tree_add_raw()
>       lsm: fix the security_namespace_init() kernel-doc
>       selftests/bpf: add a lifecycle test for the namespace LSM hooks
>
>  fs/namespace.c                                     |   6 +-
>  include/linux/ns_common.h                          |  16 ++-
>  include/linux/nstree.h                             |  29 +----
>  ipc/namespace.c                                    |   3 +-
>  kernel/bpf/bpf_lsm.c                               |   2 +
>  kernel/nscommon.c                                  |   7 +-
>  kernel/nstree.c                                    |   2 +-
>  net/core/net_namespace.c                           |   4 +-
>  security/landlock/ns.c                             |  11 +-
>  security/security.c                                |   9 +-
>  .../selftests/bpf/prog_tests/ns_lifecycle.c        | 145 +++++++++++++++=
++++++
>  tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
>  .../selftests/bpf/progs/test_ns_lifecycle.c        |  88 +++++++++++++
>  .../selftests/bpf/progs/verifier_lsm_namespace.c   |  38 ++++++
>  .../testing/selftests/bpf/test_kmods/bpf_testmod.c |   5 +
>  .../selftests/bpf/test_kmods/bpf_testmod_kfunc.h   |   1 +
>  16 files changed, 314 insertions(+), 54 deletions(-)
> ---
> base-commit: 21a7f44fd0765fcc5194130b28767786eba1d1e7
> change-id: 20261026-work-security-namespace_free-7aaf89b5b00e

--=20
paul-moore.com
