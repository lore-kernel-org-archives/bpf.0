Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA39D4252AD
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 19:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782935052; cv=pass; b=nUVQc+oNg4Ba5EbrxQk5EiQTfQs0wYAH7dXDU8ITVhTwQ0KDcSWhUFQHofkSX+RgTn6XKuw24z1cfsOfc4v686YJIo1KA8y8kjeAM1OT/pjRZyr8ZR3LF0ylg6aOqRPRB4M7LkSoGK4tdxxK93EK8N0JnDuOcbow6+ZTMlCWxwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782935052; c=relaxed/simple;
	bh=4TUi8OOya/nK0/M6RJvFAxumtDuZTO+RQiurj4PzuxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wq0Sz4FWkWQA/lCiOivpZt1tMittFzp1cEagOzcc/CW3ueHUsYDQvDYPWXMiexwzEqqqD4oWqcpIwRU44Yi+FADUnv0tuiZUaF4/mQtjx0Sxj/krxpiMOq3I6cUS0XomXs5ONlsAcOl8ppRdKC82VCmfVWhYirtn28YQzqpdE6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rUVX7b1Y; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rUVX7b1Y"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-37d55e8d3e3so752782a91.0
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 12:44:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782935050; cv=none;
        d=google.com; s=arc-20260327;
        b=RfLyWLfq2fe2LPrhMSPfzTx+lf8tq9k609ZJiNRiupGCG3b9KWUKqfrNY9c+5P2gv6
         282jelR2KM7fhG3g41ENJWX5h+WvPgGMoGexcV2iFUeE9xQHqQf4pg/KCln3Pc9gcEMP
         OuZ6oRkPQccyo7ZfT81IO0iGp2mupTGgR5aq2+Jqk89qCMzoDESKjr1Yw6q/du+2WYqR
         mVrToyfu/VZjDluSSjPNSkXLOe4W+NLaQWplKpDGUvzDuWRQp9dLKYhesM1o1H+GnuP/
         eaQq5W4x4ek1ifHtkOSaTpP9zG+fb5+PMN4lxDL+m0RDRF0AyVXcxqVyYhH5UMDGZC3S
         0QFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zXAAs1wxl7XlGQzvaNvNzAFZOlWamfbR6NSxm/5s8Rg=;
        fh=Dpja4odWFHJu3ow81Ddz4gEtkzFY16vECOMRgkaKLwg=;
        b=CFXvf5K/Hru8N3pa/XHRM2ENilV+z0KLKEV3juHwc6eNVgay/UjceSmmPpIFNC2CTH
         TercKdWUVoc/xcEH2OI9APcU6wkoABFU+Yc23QiPeJuy1G1JFfvbnwxQXMdjNs0SusS/
         I22qOpdZK0LZueLcqtKrBE3GWKSvh+uRhjmBoxD7DmU1l024Hz3I+zazxNVAVF/UgZFw
         jeSQRpwz2XVp5E/PIl1QJZ67Nm37VIDyvYvh8HlfDdewfhNhiBOpPTnH0PaFTVT6oDFN
         6Cs0MNRVvci9tRey2i/Y3tXRhRcvNCvue9V9knBBV38TF/jqmgTxzvf+TlpD+LhMH/fB
         LPrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782935050; x=1783539850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXAAs1wxl7XlGQzvaNvNzAFZOlWamfbR6NSxm/5s8Rg=;
        b=rUVX7b1Y0SuKTsfmpTFs1YCrW5Zk4I2GE24k43LRcXbWKqVnU5y0yL6JYyRzdzP4eo
         fgb4MKDRLSsoeYx2q4SziFX6z1m7r+eITkMDgMXqtiRJ0BwcF2gjsJZeMiZsqnCjegRy
         bhqvH28x/gPp1TL8LWxkAtpNoIyID6fidabUHhEjT/QVo/zQ2lPWJhvpN/uzQIUYFZyl
         B0/zVky29sEjMBhviJSOgiaHplzcGQhN+066/RwgPfLqHjslMgeg1D+x+qk1trutyUa6
         8KCrOyAJFx+EHp/04TpCFewCG4MFQp2RnmV1q8SVNxx9FDc491S7ZZjsQT0nIZCVlJby
         ICsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782935050; x=1783539850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zXAAs1wxl7XlGQzvaNvNzAFZOlWamfbR6NSxm/5s8Rg=;
        b=kHx1Tna0Af7MgkzqI5j8xvoU6Q816DPvhW4igTVqwpCp5ofkqgt8kY0AP7/2reYJrk
         PFHpCdQaBhqEbQjLZpI7F/K8c7gK8AIxjhAlNCNSp5NptFJHU8RCgSW9bXa1O+yiyRuR
         PbJfkLsC7No7Hn1+smsOrnkWwts7ztqVHAOBw6jqnUZv6rss8tYNJk50Q03hbiEbuNzF
         ojfuFMj5uK1uwugT6NcH2xwOgQPo8St2q3IiFHfk2w/sdWeEgY2JcRnhGyfP0+uda5Pn
         VUB4xTAkte/3GvWImatwFzzKcDOAzAQNaGn0HOjAnfycwd3LPU4F7Bd74KLyPp2wNN1g
         IULg==
X-Forwarded-Encrypted: i=1; AHgh+Rpiz7KA+fk6zSwFgz/3QxTOqQ86L02WgAgSBP9YPcWZJu5kw2sIz3P+qdlyLhZ69U0lpPE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2cEI6j6dAfXXV5vtf0y7iTNV8LfaSQyVqkjzPhuulZF+RATq5
	3pgQ5kyKUpOA3LI1ioZkd1prrYYixgF2ob6rZyqyLddLv8RgDcn8rwZhcCmbAjjNYZ7tCDxO+ed
	Nw1SuozJR2uqInNQrRwlGUdC8Tuu35RQ=
X-Gm-Gg: AfdE7cn8wl9kU+yRJmpmb4TYsgnbGEsaNwdSkwQclkT3EH5apknRMJD2iPsYKChJ/Hj
	5WgKdlCC6tSaVsQFfQ4E0Bkgomvq+QrPU782WthEGtSIjZHIxvOlfy16n6NGYth019OyEu7sA3v
	NPizdJuM7IvEbH8yF/t72LWJYnaQFkK+2369JiLiFDwT0Wh98upZzl9tY4T/U0y/ImojKr/F/Ji
	OkKisBdcJVE57uxqu/eDjifBKiOh1AtCL4l9gnDLd9P5FuB3dL3Pqy+OzS5zh3N9KqJdg42xvzS
	r3TrffhnburRAUAlnrGClwEKEq2oXjZEvOhuBevpQazKEBU1QArucDZHJ3f3k1df
X-Received: by 2002:a17:90b:5204:b0:37f:9e21:91d7 with SMTP id
 98e67ed59e1d1-380aa1ffe6emr2885700a91.14.1782935050079; Wed, 01 Jul 2026
 12:44:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629212208.895962-1-jolsa@kernel.org> <20260629212208.895962-4-jolsa@kernel.org>
In-Reply-To: <20260629212208.895962-4-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 Jul 2026 12:43:57 -0700
X-Gm-Features: AVVi8CfnQnstd19jcwqta-fpV1UBTNIDpOUTaS1hEU7X3P3v7JNbsEyr-hlKNb4
Message-ID: <CAEf4Bzazojh00d16MbXQGsk-ibbbDp9x2NZxHkgV5Fy5uVyUeA@mail.gmail.com>
Subject: Re: [PATCHv4 bpf-next 3/3] bpftool: Add tracing_multi link info output
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, Quentin Monnet <qmo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 2:22=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding bpftool support to show tracing_multi link details,
> the new output looks like:
>
>   # bpftool link
>   ...
>   61: tracing_multi  prog 167
>           attach_type trace_fentry_multi  btf_obj_id 1  count 3
>           btf_id           addr             cookie           func [module=
]
>           92598            ffffffff825017c4 10               bpf_fentry_t=
est1
>           92600            ffffffff82503814 30               bpf_fentry_t=
est2
>           92601            ffffffff82503824 20               bpf_fentry_t=
est3
>           pids test_progs(1540)
>
> Assisted-by: Codex:GPT-5
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/bpf/bpftool/link.c | 133 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 133 insertions(+)
>

[...]

>  static void show_perf_event_kprobe_plain(struct bpf_link_info *info)
>  {
>         const char *buf;
> @@ -989,6 +1097,9 @@ static int show_link_close_plain(int fd, struct bpf_=
link_info *info)
>         case BPF_LINK_TYPE_UPROBE_MULTI:
>                 show_uprobe_multi_plain(info);
>                 break;
> +       case BPF_LINK_TYPE_TRACING_MULTI:
> +               show_tracing_multi_plain(info);
> +               break;
>         case BPF_LINK_TYPE_PERF_EVENT:
>                 switch (info->perf_event.type) {
>                 case BPF_PERF_EVENT_EVENT:
> @@ -1029,6 +1140,7 @@ static int show_link_close_plain(int fd, struct bpf=
_link_info *info)
>  static int do_show_link(int fd)
>  {
>         __u64 *ref_ctr_offsets =3D NULL, *offsets =3D NULL, *cookies =3D =
NULL;
> +       __u32 *ids =3D NULL;
>         struct bpf_link_info info;
>         __u32 len =3D sizeof(info);
>         char path_buf[PATH_MAX];
> @@ -1114,6 +1226,26 @@ static int do_show_link(int fd)
>                         goto again;
>                 }
>         }
> +       if (info.type =3D=3D BPF_LINK_TYPE_TRACING_MULTI && !info.tracing=
_multi.ids) {

`&& info.tracing_multi.count` and avoid that nested if (just use
info.tracing_multi.count directly for callocs())


just a nit for maybe a follow up, if you care

> +               count =3D info.tracing_multi.count;
> +               if (count) {
> +                       ids =3D calloc(count, sizeof(__u32));
> +                       addrs =3D calloc(count, sizeof(__u64));
> +                       cookies =3D calloc(count, sizeof(__u64));
> +                       if (!ids || !addrs || !cookies) {
> +                               p_err("mem alloc failed");
> +                               close(fd);
> +                               free(cookies);
> +                               free(addrs);
> +                               free(ids);
> +                               return -ENOMEM;
> +                       }
> +                       info.tracing_multi.ids =3D ptr_to_u64(ids);
> +                       info.tracing_multi.addrs =3D ptr_to_u64(addrs);
> +                       info.tracing_multi.cookies =3D ptr_to_u64(cookies=
);
> +                       goto again;
> +               }
> +       }
>         if (info.type =3D=3D BPF_LINK_TYPE_PERF_EVENT) {
>                 switch (info.perf_event.type) {
>                 case BPF_PERF_EVENT_TRACEPOINT:
> @@ -1153,6 +1285,7 @@ static int do_show_link(int fd)
>         free(cookies);
>         free(offsets);
>         free(addrs);
> +       free(ids);
>         close(fd);
>         return 0;
>  }
> --
> 2.54.0
>
