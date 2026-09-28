Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9051B35C6B4
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 01:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790559663; cv=pass; b=rUAryxweogqBnL2rqeTpE8qDKGF2msj97Utb/afPwWIjlnu1GX5bYZARXi+W+cIvU2AcEjDwBkbHzsJFfQYC9JVVhWvEB4kBmKDcnTiJdr4ggsu4PcibMEM+DvxK+aN/CsNjAa4zvirxF1wM+JJD1+3uDjeMlmSWlC4UGnYeFds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790559663; c=relaxed/simple;
	bh=xKWU93v/um3fUtrsZPACgMoPebmYvEHQBLvCGMbzDZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DJzAE1dtWZm50qOofetzB6mcLQ8/mOS2WO0hAkTVVHMidBg433MRUnGWtUvMcRNU8MXDfyC0By3rsw5++EPY33s60lRe77Uy41kJuBsT4ltlAqoVLDHVdgoFdW6OelRjOxT5KEgFfp7xuQgvKFjvTHn0L6vuq8DS+oPP5wWta4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=xlkhFj+6; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=d+DeZY38; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="xlkhFj+6";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="d+DeZY38"
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68RMsXQx144187
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 01:40:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=q6IIkgVZc607wo+BrqTCfj0dKv8qlSJ+UFTBAGog+vk=; b=xlkh
	Fj+6QLyoAIXLydYCjDEdTCgsjCycSTdI60Ag+N3yOHuystP8412A+I+q9uvrqjjm
	eExGFdTXBrTKMzXCaLnpaqm730SmhITGBwHP0qD48GHx8tZA7XPEW2gr23wLgq/t
	kqm5naGPYNmCIj/IFx/ApiWav0JE1NoPNvVZHub3YRhSRy91OXoY/THzl3Q6EqfF
	SPbcLLE4R2iCuz/36/O53SWpkoIsKdpf6wjHUIwSXOzlhTYS7otDBpbdt/bkUfN0
	wioKiCVY+LfsG2kM1NgztyUgPUYRRpafDqfuf0eX2IjlnCFKrioipxaES86tfD9a
	PdK++roMEuifgMRraw==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4gxuv01v6k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 01:40:54 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-836caf085e0so36340557b3.1
        for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 18:40:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790559653; cv=none;
        d=google.com; s=arc-20260327;
        b=geumlXv5n0eZmRHlFFDih3NsNOtj+w2A6PpsZnzGQW1jiRbvydget3pDQf79tkcKwn
         rReI3dPMROR3p2mAFgAwpFUah+S+Kd70CLrbXr3KrCJZL7UU+HXEZiC2vQLgeZZjg8YY
         P1pazWVuwqredqt7a8/S9X4lTMyUq/YtMWsX1YSgx3Jp2CRQoOgEpmLa+uczbX3ndKkJ
         Vef+OFD0RlGxuPq980sD+eWRVcGC9MAE9Y7ew+p0hfi97bVVjSjn7asfOow91CiI1G0F
         1C53gDy6cWHfEiBj4lMjQp7shNqELSit+1KPlvpbzYVJfL882vM5YvD1oAIvRpv85Sv0
         FAmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q6IIkgVZc607wo+BrqTCfj0dKv8qlSJ+UFTBAGog+vk=;
        fh=HqrJM6V40biUU84FbF3b+a600FTEtdxdMqPUb/S6rsw=;
        b=ft96zo9Apo60VTLyz7cKq89lBbiwchydk7joZzVDIH76kkJfKrF9sziXOL5VoDFhfb
         fHPY0AVXGviMh5Dwmlcbj0k3tTtwPjiktFz/8XBqQP7q3pWH4LpDpb07BpsmOkbqXBmK
         LazbRu/64JM1ooDO6LVAzphEbujWbTKkSrekmyYHcd/JuJdb/nFo6KXMa5d5x2A0eC3w
         5/9KL3QV8sHlkt4CCDWDV8hhiPWHmw6+RdyC9zvKz9Tlj/tqVycTVw+jFnqFFgvjD8dV
         7TOZrxCzsNvtdOHxhBX1yxoNy9uuUGFUBe2ixCdARDkwbgGKKCz9IIzu+oRJVPHRXu56
         tNOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1790559653; x=1791164453; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q6IIkgVZc607wo+BrqTCfj0dKv8qlSJ+UFTBAGog+vk=;
        b=d+DeZY388p4u4nUuCTkmDJv59CRACZUQRU1PhJeZw7TygTyeZ6OBuspAOBmIRNaA89
         FItNKMztlsJuykpUbhB3+N4Q6Y+vTyafLIlhuednf8mZNxKJo/VqOYK0sjHkei9Bv1bi
         +Jtso/kJ+nkJVhElLigtxallt9nhCcAP1ErnhuV2B+C0V0Gw3HUJASCUnEcsTeBi9Ub0
         UaWA70a0nWKTUQ4Tz6g7M1Zb6/tvdSIiY25YIjM4TLiPMjtpY7kVvEYKwBhgkAI2Rxls
         8ySJw6rb0BcdpP4XG/eOx0yElDvwkFWERNEUsj41TA4S8X89nbMFi7goPmq7iUjm/tQ2
         HbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790559653; x=1791164453;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q6IIkgVZc607wo+BrqTCfj0dKv8qlSJ+UFTBAGog+vk=;
        b=mHzMDTXAtpVvN8kmfLA2Cd+dMQazuYcMZMDc6dTYKB7An9PnpTGW+HIk0YyE9cepj8
         2m4Of8SCFyR/gi7bbkSSfG+TBDpMXPBePf/iqzOMFtT3Eb83iBO7Ix9iIMePhH1XWWGj
         XenNK/w4TX68UYaa+BocmzBCGLy1udkIHqYuH2ymw8sxZwSLE3P1zmLMc7OoalnfuvLG
         8kIyNvVn3QAQOep9kGw/7j2c7JcQoAZtpChlj+MtZTQcnYuUShccEenE6wGCYdIUylRZ
         Fmq5o7tKjfBY5FIPVrb16078PI6r27SRTNnQ+k3YqX78tOnUrkK0WtNDnZG1Q+4VDd+4
         T8yw==
X-Gm-Message-State: AFq9FYKliKJz89JtWCtfWgR1Bwi0dhw2ZDswZef8C9eobj1wGd+t9s0s
	1MaJAuRYoK2/S3wfImQx5ov46455cj1uZPrPgPkhadXfdXR3ctLtKNSG55ZixfbHauYR7NGs88Y
	8MNsR00uhJwhOksXB5BWWlQ3z3v4qhQK3O0OETp5jpzh9elv11zRlVp96bGKTV8nOBz93y8Nyg2
	Jmr5dBOu9lRXgXtPFzF1WLxV3DJ7hc
X-Gm-Gg: AYBFou26UY+t88MpAJ/2TtBhDN8mjHb876BKMCLoyWyoTyQZqiuiJvW35aIgYjMxdoi
	CLAnmHptxXFFBfRzxVeBHysP54ABWlWI8aAshwknCYJCalFeijoK27Xx0hs5+5EhOniumrhQzVW
	n4x9cVNGmClZmaSfvoe5c/DFqJCDh2/tdxffqBp1AsQqnDZRe0jWMZ/lyZ9Q==
X-Received: by 2002:a05:690c:a7c6:b0:8a8:4931:6198 with SMTP id 00721157ae682-8a84940abd2mr30624217b3.43.1790559653530;
        Sun, 27 Sep 2026 18:40:53 -0700 (PDT)
X-Received: by 2002:a05:690c:a7c6:b0:8a8:4931:6198 with SMTP id
 00721157ae682-8a84940abd2mr30624177b3.43.1790559652973; Sun, 27 Sep 2026
 18:40:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923232939.1886328-3-andrey.grodzovsky@crowdstrike.com> <68df9eab1022e5ac30007383b6f5a85dc6d7c9884edccc5f4c84cdeb9b32d427@mail.kernel.org>
In-Reply-To: <68df9eab1022e5ac30007383b6f5a85dc6d7c9884edccc5f4c84cdeb9b32d427@mail.kernel.org>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Sun, 27 Sep 2026 21:40:41 -0400
X-Gm-Features: AclHuK9n-yJcTOFWmwVMPDFpX59ebbna9DhPAcj8wyGwF9dEaUvWEutVlZ3Yzt0
Message-ID: <CAOu3gNi-Vo=k6Xih9ywJ0wji=JZeNbFnNkV1fmRQU5Mk8WGd1A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/8] libbpf: BPF programs manual loading and attaching
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        martin.kelly@crowdstrike.com, slava.imameev@crowdstrike.com,
        linux-open-source@crowdstrike.com, daniel@iogearbox.net,
        martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
        mason@kernel.org, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: n9wFvWMeG1G_GbwKiWk7lnibFn-RgtaU
X-Authority-Analysis: v=2.4 cv=NZxzRGD4 c=1 sm=1 tr=0 ts=6ab9c5a6 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=2KvRFfd_T_-xjmS8C1aD:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=Pgacwa0oAAAA:8
 a=iFABrAoMAAAA:20 a=NEAV23lmAAAA:8 a=3P11AtvG3jdKMAIeKb0A:9 a=QEXdDO2ut3YA:10
 a=kLokIza1BN8a-hAJ3hfR:22 a=xnLNWz09G3ZUmE6K9NTY:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAwNiBTYWx0ZWRfX7DXMWnrB/r11
 Mer6reZ/JuwwlL8jeSf6+RSkoP6fEM/tCh21nwgcjirvJjgs52x/351v/tA9r0lSYl8S2kJbGpG
 Hi4FOzm6LEkVV1ZBO7G1k9ESL+kMM0sRPnzinIKtHhy5/oWTBlhurcQhBdJTJUTRrMrw/KBl3Vx
 kssorpAZxqBuZ3cPsxEl24v8KRXVTBEwchjixvqcPihKXII0Xcke+7yjtSc435UQoIRRo3ehDJX
 Kb1zNewQu3pz/PjQEGH8u6cSaUUaQtMGstL+ERpfIhhoUP9TzdarRbzJlN6ETPScklBCwtXIDMI
 RE/vYPpFhiqBEGCyUiuBdyl7m1MpdRuFqWBgQVnqrQAHF8YbqMTBIaUF5AlKnSSgJpP392+vH8m
 +6DY9TxeXQ3ZnaRX5nAgdIfm1eODtSf2JkHwiZmWuX2alqA6cC9Yu9HTXmvDlxot68w1/GD68Ab
 Xxd0dLAgARZqV4Gq6lw==
X-Proofpoint-GUID: n9wFvWMeG1G_GbwKiWk7lnibFn-RgtaU
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAwNiBTYWx0ZWRfX9Wicn/QkCNwW
 sr9G6/yR0hgBrNY2dIzGNIAnooF7sKA1UWuGGSk58xa8GToS1mDPnj3vHRIjbDfS3wiyrdHryBV
 7Yjy/Iunf/vegCEkZoM1xa4kMDgYASyqy5XPB8AtCjXwKUvkhRlU
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11918
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280006

On Wed, Sep 23, 2026 at 8:32=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index a3085847cb97f..939f0d6378e38 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
>
> [ ... ]
>
> > @@ -15375,10 +15431,69 @@ void bpf_object__destroy_skeleton(struct bpf_=
object_skeleton *s)
> >
> >  int bpf_program__set_load_strategy(struct bpf_program *prog, enum bpf_=
prog_load_strategy strategy)
> >  {
> > -     if (prog->obj->state >=3D OBJ_LOADED)
> > +     struct bpf_object *obj =3D prog->obj;
> > +
> > +     if (strategy =3D=3D BPF_PROG_LOAD_STRATEGY_MANUAL ||
> > +         prog->load_strategy =3D=3D BPF_PROG_LOAD_STRATEGY_MANUAL) {
> > +             if (obj->state >=3D OBJ_PREPARED)
> > +                     return libbpf_err(-EINVAL);
> > +     } else if (obj->state >=3D OBJ_LOADED) {
> >               return libbpf_err(-EINVAL);
> > +     }
> > +
> > +     if (strategy =3D=3D prog->load_strategy)
> > +             return 0;
> > +
> > +     switch (strategy) {
> > +     case BPF_PROG_LOAD_STRATEGY_DISABLED:
> > +     case BPF_PROG_LOAD_STRATEGY_AUTO:
> > +             if (prog->load_strategy =3D=3D BPF_PROG_LOAD_STRATEGY_MAN=
UAL)
> > +                     prog->autoattach =3D prog->saved_autoattach;
> > +             prog->load_strategy =3D strategy;
> > +             break;
> > +     case BPF_PROG_LOAD_STRATEGY_MANUAL:
> > +             if (obj->gen_loader)
> > +                     return libbpf_err(-EOPNOTSUPP);
>
> Can this ordering be reversed? When bpf_program__set_load_strategy(MANUAL=
)
> is called before bpf_object__gen_loader(), this check passes because
> obj->gen_loader is still NULL. Then when bpf_object__gen_loader() runs
> later, it doesn't check whether any MANUAL programs already exist.
>
> Looking at bpf_object__load_progs():
>
>     for (i =3D 0; i < obj->nr_programs; i++) {
>         prog =3D &obj->programs[i];
>         if (!prog->autoload || prog->load_strategy !=3D BPF_PROG_LOAD_STR=
ATEGY_AUTO) {
>             pr_debug("prog '%s': skipped auto-loading\n", prog->name);
>             continue;
>         }
>
> MANUAL programs are skipped, so gen->nr_progs ends up below
> obj->nr_programs. Then bpf_gen__finish() only rejects nr_progs <
> gen->nr_progs, so the generated loader silently omits these programs.
>
> If someone later calls bpf_program__load() on the MANUAL program, it goes
> through bpf_object_load_prog()'s gen_loader path:
>
>     if (obj->gen_loader) {
>         bpf_gen__prog_load(obj->gen_loader, ...);
>         *prog_fd =3D -1;
>         return 0;
>     }
>
> which returns success with prog->fd =3D -1 and appends to gen buffers aft=
er
> bpf_gen__finish() has already published opts->insns/opts->data. Since
> gen_loader grows buffers with realloc(), this can leave those pointers
> stale.
>
> Note: This is fixed later in the series by 549383b4eb184 ("libbpf: Reject
> gen_loader for objects with already-manual programs").
>
> > +             if (prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS)
> > +                     return libbpf_err(-EINVAL);
> > +
> > +             if (prog_is_subprog(obj, prog))
> > +                     return libbpf_err(-EINVAL);
> > +
> > +             prog->saved_autoattach =3D prog->autoattach;
> > +             prog->load_strategy =3D BPF_PROG_LOAD_STRATEGY_MANUAL;
> > +             prog->autoattach =3D false;
> > +             break;
> > +     default:
> > +             return libbpf_err(-EINVAL);
> > +     }
> > +
> >       return 0;
> >  }
> >
> > @@ -15386,3 +15501,34 @@ enum bpf_prog_load_strategy bpf_program__load_=
strategy(const struct bpf_program
> >  {
> >       return prog->load_strategy;
> >  }
> > +
> > +int
> > +bpf_program__load(struct bpf_program *prog)
> > +{
> > +     int err;
> > +     struct bpf_object *obj =3D prog->obj;
> > +
> > +     if (obj->state < OBF_PREPARED)
> > +             return libbpf_err(-EINVAL);
> > +
> > +     if (prog_is_subprog(obj, prog) || prog->load_strategy !=3D BPF_PR=
OG_LOAD_STRATEGY_MANUAL)
> > +             return libbpf_err(-EINVAL);
> > +
> > +     if (prog->fd >=3D 0)
> > +             return libbpf_err(-EBUSY);
> > +
> > +     err =3D bpf_object_load_prog(obj, prog, prog->insns, prog->insns_=
cnt,
> > +                                obj->license, obj->kern_version, &prog=
->fd);
> > +     if (err) {
> > +             pr_warn("prog '%s': failed to load: %s\n", prog->name, er=
rstr(err));
> > +             return libbpf_err(err);
> > +     }
> > +
> > +     return 0;
> > +}
>
> The commit message says MANUAL programs "can also be reloaded and
> reattached multiple times", and the bpf_program__unload() doc now says
> MANUAL programs keep their data "so it can be reloaded later via
> bpf_program__load()". Does this work for programs that use gotox jump
> tables?
>
> During bpf_object__prepare(), create_jt_map() creates a
> BPF_MAP_TYPE_INSN_ARRAY map per (prog, sym_off) and caches it in
> obj->jumptable_maps. RELO_INSN_ARRAY then writes the map fd directly into
> prog->insns (insn->imm =3D map_fd). Each bpf_program__load() call
> resubmits the same prog->insns with the same map fd.
>
> On the kernel side, bpf_insn_array_init() runs:
>
>     if (atomic_xchg(&insn_array->used, 1))
>         return -EBUSY;
>
> with the message "There can be only one program using the map". That flag
> is cleared only by bpf_insn_array_release(), which the verifier calls on
> the verification error path, not when a successfully loaded program is
> freed.
>
> So this sequence:
>
>     bpf_object__prepare()
>     bpf_program__load(p)    // ok, insn_array->used =3D 0 -> 1
>     bpf_program__unload(p)  // just zclose(prog->fd)
>     bpf_program__load(p)    // -EBUSY, insn_array->used still 1
>
> fails verification with "Failed to properly initialize insn array". The
> map and its 'used' state live on in obj->jumptable_maps until
> bpf_object__close().
>
> Would libbpf need to recreate the jump-table maps (and re-patch insn->imm=
)
> before each manual load, or should this limitation be rejected or
> documented?

This is indeed an issue, but not specific to our manual loading progs.
I was able to reproduce a pretty similar behavior using the exsiting
bpf_program__clone() interface by writing a test for the recently
added "Indirect call of bpf subprog" feature by Alexei [1] - I
prepared and cloned a program which calls function by a func pointer
from a table, first clone worked fine, while the second generated the
failure + kernel log below.  Another test also verified that
subsequent bpf_object__load()  after the first clone also failed with
same error.
I wasn't able to run the gotox scenario since my LLVM didn't support gotox.

dynamicload_verify_callx_clone_twice:PASS:bpf_object__prepare 0 nsec
dynamicload_verify_callx_clone_twice:PASS:callx_clone_first 0 nsec
callx_clone_second: clone failed: -16
-- BEGIN KERNEL LOG --
map 'test_dyn.rodata' has addresses of functions of another program
processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0
peak_states 0 mark_read 0
-- END KERNEL LOG --

So I am not sure we should look for and reject all those types of
cases where the first loaded program captures a map exclusively, given
that the first load will work normally.  Perhaps document it....

Andrey
[1] - https://lore.kernel.org/bpf/20260922011323.1298619-11-alexei.starovoi=
tov@gmail.com/

>
> > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > index e7255bd4247f7..faea42f758479 100644
> > --- a/tools/lib/bpf/libbpf.h
> > +++ b/tools/lib/bpf/libbpf.h
> > @@ -392,7 +392,7 @@ LIBBPF_API const char *bpf_program__section_name(co=
nst struct bpf_program *prog)
> >  LIBBPF_API bool bpf_program__autoload(const struct bpf_program *prog);
> >  LIBBPF_API int bpf_program__set_autoload(struct bpf_program *prog, boo=
l autoload);
> >  LIBBPF_API bool bpf_program__autoattach(const struct bpf_program *prog=
);
> > -LIBBPF_API void bpf_program__set_autoattach(struct bpf_program *prog, =
bool autoattach);
> > +LIBBPF_API int bpf_program__set_autoattach(struct bpf_program *prog, b=
ool autoattach);
>
> The return type of the public LIBBPF_API bpf_program__set_autoattach()
> changes from void to int, but the symbol stays in its original
> https://urldefense.com/v3/__http://libbpf.map__;!!BmdzS3_lV9HdKG8!zC1ATni=
phW52dqH2YnKa3C_GBu6XJsWup4Mbx4WwxlDc2udDHlre3KohEAG5kA8e6eh0iQUU_SXCP148Dh=
evtSg6kBnoMe4M$  node. This is source compatible, but callers that ignore t=
he
> result cannot tell that the call was rejected for MANUAL programs, and th=
e
> ABI of an already exported symbol changes without a new version node.
>
> Note: This is fixed later in the series by fca8106ae09c7 ("libbpf:
> Version bpf_program__set_autoattach() ABI change").
>
> > diff --git a/tools/lib/bpf/https://urldefense.com/v3/__http://libbpf.ma=
p__;!!BmdzS3_lV9HdKG8!zC1ATniphW52dqH2YnKa3C_GBu6XJsWup4Mbx4WwxlDc2udDHlre3=
KohEAG5kA8e6eh0iQUU_SXCP148DhevtSg6kBnoMe4M$  b/tools/lib/bpf/https://urlde=
fense.com/v3/__http://libbpf.map__;!!BmdzS3_lV9HdKG8!zC1ATniphW52dqH2YnKa3C=
_GBu6XJsWup4Mbx4WwxlDc2udDHlre3KohEAG5kA8e6eh0iQUU_SXCP148DhevtSg6kBnoMe4M$
> > index 03c3d2bd15bf4..8def5474885a8 100644
> > --- a/tools/lib/bpf/https://urldefense.com/v3/__http://libbpf.map__;!!B=
mdzS3_lV9HdKG8!zC1ATniphW52dqH2YnKa3C_GBu6XJsWup4Mbx4WwxlDc2udDHlre3KohEAG5=
kA8e6eh0iQUU_SXCP148DhevtSg6kBnoMe4M$
> > +++ b/tools/lib/bpf/https://urldefense.com/v3/__http://libbpf.map__;!!B=
mdzS3_lV9HdKG8!zC1ATniphW52dqH2YnKa3C_GBu6XJsWup4Mbx4WwxlDc2udDHlre3KohEAG5=
kA8e6eh0iQUU_SXCP148DhevtSg6kBnoMe4M$
> > @@ -463,6 +463,7 @@ LIBBPF_1.8.0 {
> >               bpf_program__attach_tracing_multi;
> >               bpf_program__clear_flags;
> >               bpf_program__clone;
> > +             bpf_program__load;
> >               bpf_program__load_strategy;
> >               bpf_program__set_load_strategy;
> >               btf__find_by_name_kind_own;
>
> The commit message refers to bpf_program__load_manually() and
> bpf_program__unload_manually():
>
> >     A manual-strategy program is loaded via bpf_program__load_manually(=
)
> >     and unloaded via bpf_program__unload_manually(), gated on
> >     bpf_object__prepare() having already run (BTF loaded, maps created,
> >     relocations applied) rather than requiring a full bpf_object__load(=
).
>
> Neither function exists. The patch actually adds bpf_program__load()
> (exported in LIBBPF_1.8.0) and changes the existing bpf_program__unload()
> so that it only closes the fd for MANUAL programs. The message also leave=
s
> out the user-visible change to bpf_program__set_autoattach(): it now
> returns int and rejects MANUAL programs.
>
> In the v1 review thread, Andrii Nakryiko expressed concern about adding
> complexity to bpf_object internals:
>
> > I don't want to complicate bpf_object internals with this third
> > autoload state, as this creates tons of non-obvious gotchas that have
> > to constantly be checked whenever any new feature is added to
> > bpf_object (or even during refactorings).
>
> From: https://urldefense.com/v3/__https://lore.kernel.org/bpf/CAEf4BzYWe0=
KCzA4-qwAGp5n_ydJ0_zyLSO=3DCrr_vewFHzZ0t6Q@mail.gmail.com/__;!!BmdzS3_lV9Hd=
KG8!zC1ATniphW52dqH2YnKa3C_GBu6XJsWup4Mbx4WwxlDc2udDHlre3KohEAG5kA8e6eh0iQU=
U_SXCP148DhevtSg6kHoTp1qY$
>
> While the patch has been revised to use bpf_object__prepare() as Andrii
> suggested, does the implementation still add significant complexity: new
> state tracking (has_manual_progs), modified cleanup logic with force
> parameter, complex state machine logic for load strategies, and deferred
> BTF/fd_array cleanup?
>
> Also, for subsequent submissions, Andrii requested the [PATCH bpf-next]
> subject prefix in the v1 review.
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://urldefense.com/v3/__https://github.com/kernel-patches/vmtest=
/blob/master/ci/claude/README.md__;!!BmdzS3_lV9HdKG8!zC1ATniphW52dqH2YnKa3C=
_GBu6XJsWup4Mbx4WwxlDc2udDHlre3KohEAG5kA8e6eh0iQUU_SXCP148DhevtSg6kIlMmsxY$
>
> CI run summary: https://urldefense.com/v3/__https://github.com/kernel-pat=
ches/bpf/actions/runs/35934836796__;!!BmdzS3_lV9HdKG8!zC1ATniphW52dqH2YnKa3=
C_GBu6XJsWup4Mbx4WwxlDc2udDHlre3KohEAG5kA8e6eh0iQUU_SXCP148DhevtSg6kMF5-RGT=
$
