Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1A045D5F3
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 06:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392970; cv=pass; b=FYWkR9S1kd1F49N8oKY0Uf7mrWBnqsmQf0FJPwRKXyhy8WUd09yUEx+YFVP4xT22HHR7w9OXUejScZxuJixdxe6SUN0VD0J8VX2rKILvXcbA6ctvGMUvMDb2AaPF4XpNQqffVGxBvW70wYMYcCegBG2HlM0Fy39mGE0H43P8HKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392970; c=relaxed/simple;
	bh=X9zh+Cp4pC1VXTkySHPCj16XhQytW+vw6iww+Xpynhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HkwJIjRx9jaR7UjbKmwkFhlKp+q4t7B6CXHKUw4eysfccK5/c6/bveltNgg30yi5cs5UyFE8oCclcyBCGexaeGRrZe4esrkkuoFUaNRLyuXn/N2852WpMNohihIcXGlUVu0risyVuk96cxcry4pSw42zS7yk7EJoFsrNzYkj0pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rzJHpEZf; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rzJHpEZf"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-67489c8202cso1401561d50.3
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 23:56:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792392968; cv=none;
        d=google.com; s=arc-20260327;
        b=QwRArA3e1CWIa6MnkupnwOpK7q2trLIVHRM0k2XDBmar10PLJeh0mIXZVp755rTz8o
         NXKF3Q86kr2HpbUhAujLaBrzIQzWjWUEI9FHZnLR/KgoKBHC5ncTQiW2lcGzS5ZXpSwz
         09eKX3cYopLPwvpFr/DuBlUYArW2AA9lDA1pCKD23Nuw3R7zQW6XaKRUUETkrQnh5d3X
         6lTYucmoOiSPC0TTw7tsqfaWCnARp9n/G92ZDIUHs49+4qwgXOEL+S+GjiK5+EFPQ3K9
         qSw+CRCWw1GF5r8rWlJBOyuf7JkdBEiKG+nkt1DeNMbjjE6HZl56eqPMecVl9tmMIf6j
         N3iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vaaaBizOm7JbDRKbdirZXLgkf0levtE0Ftrfaqs1NqU=;
        fh=nPYnfl5ZiXKtFolleBQ0v42ZMyGTtVN/FRlVbz+SED4=;
        b=B4bGXki/rFEgtnBSgpjol8Bjhuk1oNDbV1//f35TtLW1drYNFSjFV1/IwAjGWvofFv
         28lFyngG2/WvYFx/5LiTrpMrt0Y4EueLrkw8/kD1TNI95SvuKg6pYi63CcZY2AWv8Ptq
         UBKvftBJ827gYXLt48bwJYpagrcCcOTE55rZx9OjJ653BUo3otdf8hlh0NMNog7HWtVV
         30Ykd8KiNgV2RLhg+5WA+a3UTGGU0/DWuRH/bL1xPhQ+m+Nh4svYzOMo7QILIw+Nb+Jz
         BrvxP0fKSSPPu4Zg7XVpeafP/HMcTuCpU7y52wTrveiZfE7qSvILgkZHexmMvdQe1qtg
         T+OA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792392968; x=1792997768; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vaaaBizOm7JbDRKbdirZXLgkf0levtE0Ftrfaqs1NqU=;
        b=rzJHpEZfCjFun6ELnWWMiaOo5ms4Ku7OI7ZtLFTTvS0osfGgojhUINMb4VnFHUi3g8
         THqI4NsuVgFfNaCeaR4g22YcSfUTHpV6ttSTuB5+Ms/akqjoIsZ9OPNCM2MYFnIutc4D
         0D4t0E/8c5iQ/cCOCV2JxZMZxw/hfUtLUsb5Di6oFbNdD9Y+9HmLDMnl/ch8MsB6ROPB
         iQ6U3Q27TlhmnDsiQx/enTZorPt1CBC1zPZnRqu+RIZ7VomNY+IKy/l4S7lRncLoEaSy
         20jdi8CRQatpLy81KUkZ1BQi0h6DY8wfBtDPNaNKNIRVl2P0t+yylu6m7Q2JccFLYTpk
         Aa2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792392968; x=1792997768;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vaaaBizOm7JbDRKbdirZXLgkf0levtE0Ftrfaqs1NqU=;
        b=Rzz0secA4/Ev4nOxKmtwAQ0dbUi31WQTreQIG2tCeFRKBmCSZQsby64byV7QXBAw+G
         cgJZAi51l8iL5ybVwdlUl0y6v7sqMC8kSLl0jf6fZNum1BiFOyEXPkE29XL/SXccafGg
         qqFahQk9LXoNcTvfnbRagLVfp5G4OEynfhBcWD/dllgSr+24Z1fUQLf33ryrYJPy6BtC
         FwaNA6qfNq6m+5lyJ0qEidlUA4bxlz/C342FyEy5XNJJ4Swg1r4kKQ4+wjb9s/VmW1ck
         Svphg3vD2a7Ej4tBd5vaR3LOBq8NUGBWzjoz6eAViL+Lxdez+BD4uP+Tbws59oecuSb5
         hQIQ==
X-Forwarded-Encrypted: i=1; AKwUvBwia8F+DbKconrgUjRVDltOCfQRuHWM9rA301g1+ScHljhJbnBbcdNkzpz78Lg5X1FJg2s=@vger.kernel.org
X-Gm-Message-State: AFq9FYJH8gwlRkdwryynXBAxZUL7YIIMts0C4+us8VjuKad0Z6o2cBNu
	LaBlSfIdHMM1peuvyQpVYz9alvsboZwOjP6BH6XljjHkb1MnVNzf8vg1W1DHmEABcPtLlAq+KEl
	T4MO2Lt1EbQiY+30P3UpguNtlvybKJgg=
X-Gm-Gg: AYBFou0c1Mk2SURm732Qne0XMkGbbA8XhVTb5cQpxma1cAaoUJ039Cp8UGo68V8kfz9
	ilW/iM6L4Ty8/9s2aJMB4j38eFctL1M42rLwQ15v76TcNSwhvMHpLEWGssmUTcKg/LTeG5S3FzH
	dtrmDMlc+iYgWoLw+xcI4XCCQVmdoisw8OKwekKFQXbBgAs8V7Zpbh1WP2qrEDgSB14qGdlvhdx
	trWVE/Tk/bmk4CIFWHi/nYGlXPVRlb+z9odcuwGMJZGVTNVG2knvtQrtlM8/g86z2jbm1/lgZNW
	FaIZLC5B6juXmwslXByYoXzeGdHaofgJm9Y35iopwf7ha0AA9DGJQEUVaRMaK9tN6putQTF8bAd
	JWsS0x+XbJg==
X-Received: by 2002:a05:690e:484d:b0:675:5e46:36cc with SMTP id
 956f58d0204a3-679ca8a6938mr1328984d50.82.1792392967945; Sun, 18 Oct 2026
 23:56:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261019064157.29885-1-laoar.shao@gmail.com> <20261019064157.29885-6-laoar.shao@gmail.com>
 <sashiko-outbox-176703@kernel.org>
In-Reply-To: <sashiko-outbox-176703@kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 19 Oct 2026 14:55:30 +0800
X-Gm-Features: AclHuK-4hRkGnv4LQq98lJIVV6E1PZLgk66c_H-_i08if73Xzq6nap7W0MhfklY
Message-ID: <CALOAHbBHcswzurP5vRqOzsKiZP6N-6J7ACnB_M2tZ1avN2NsJg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 bpf-next 5/5] selftests/bpf: add tests for the
 numab kfuncs
To: sashiko-reviews@lists.linux.dev
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, akpm@linux-foundation.org, 
	david@kernel.org, gourry@gourry.net, tj@kernel.org, hannes@cmpxchg.org, 
	mkoutny@suse.com, shakeel.butt@linux.dev, roman.gushchin@linux.dev, 
	yu.c.chen@intel.com, zhao1.liu@intel.com, tim.c.chen@linux.intel.com, 
	lizhe.67@bytedance.com, bpf@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 2:51=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] selftests/bpf: missing kfunc BTF skip check in test_bpf_numab(=
)
> --
>
> commit 07e4c14213f29b11a7ce19b88e46e524dc48e78d
> Author: Yafang Shao <laoar.shao@gmail.com>
>
> selftests/bpf: add tests for the numab kfuncs
>
> This commit adds BPF selftests exercising the bpf_numab_set_mode() and
> bpf_numab_get_mode() kfuncs across set/get roundtrips, mode validation,
> invalid cgroup IDs, and cgroup hierarchy combinations.
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_numab.c b/tools=
/testing/selftests/bpf/prog_tests/bpf_numab.c
> > new file mode 100644
> > index 0000000000000..7ce4b8153c42f
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/bpf_numab.c
> > @@ -0,0 +1,227 @@
> [ ... ]
> > +static void test_set_get(void)
> > +{
> > +     struct bpf_numab *skel;
> > +     int cgroup_fd;
> > +     u64 cgid;
> > +
> > +     cgroup_fd =3D test__join_cgroup(CGROUP_PATH);
> > +     if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
> > +             return;
> > +
> > +     skel =3D bpf_numab__open_and_load();
> > +     if (!ASSERT_OK_PTR(skel, "open_and_load"))
> > +             goto cleanup;
> [ ... ]
> > +void test_bpf_numab(void)
> > +{
> > +     if (test__start_subtest("set_get"))
> > +             test_set_get();
> > +     if (test__start_subtest("invalid_mode"))
> > +             test_invalid_mode();
> > +     if (test__start_subtest("bad_cgid"))
> > +             test_bad_cgid();
> > +     if (test__start_subtest("hierarchy"))
> > +             test_hierarchy();
> > +}
>
> [Severity: Medium]
> What happens when test_bpf_numab() runs on a kernel built without
> CONFIG_BPF_NUMAB=3Dy (for example when CONFIG_NUMA_BALANCING is disabled =
or on
> non-x86_64 selftest configs where CONFIG_NUMA_BALANCING is not enabled)?

Nice catch.
will add the configs to tools/testing/selftests/bpf/config.

>
> Because tools/testing/selftests/bpf/progs/bpf_numab.c declares
> bpf_numab_set_mode and bpf_numab_get_mode as strong __ksym externs:
>
>     extern int bpf_numab_set_mode(u64 cgid, s64 mode) __ksym;
>     extern s64 bpf_numab_get_mode(u64 cgid) __ksym;
>
> calling test_bpf_numab() -> test_set_get() -> bpf_numab__open_and_load()
> (as well as test_invalid_mode(), test_bad_cgid(), and test_hierarchy())
> fails in bpf_object__resolve_ksym_func_btf_id() with -ESRCH and trips
> ASSERT_OK_PTR(skel, "open_and_load").
>
> Should test_bpf_numab() check vmlinux BTF for bpf_numab_set_mode and
> bpf_numab_get_mode via btf__find_by_name_kind(..., BTF_KIND_FUNC) and cal=
l
> test__skip() when the kfuncs are not present?
>
> > diff --git a/tools/testing/selftests/bpf/progs/bpf_numab.c b/tools/test=
ing/selftests/bpf/progs/bpf_numab.c
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019064157.29=
885-1-laoar.shao@gmail.com?part=3D5



--=20
Regards
Yafang
