Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13EC301016
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 17:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772817768; cv=pass; b=lVVP7VZ1cHg3oaZoGZ6ipCaF7tpeUAohfzpUPB6MSmyCcfZQp+HR9iAXTOBFCwv5ayidMmvGsiSbkUbF1Vjs/BZpwgwMaz5jW8YZxbCYnAPRaDtrj5VAsV/giKDkrIN4wdGl7yUo3cWbPSzGCS+wFuc9LP/RsXTgp+64wzjb1TM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772817768; c=relaxed/simple;
	bh=TmcnfZT+uNgzSfIoKyxVIL0b9JqxTUWqkWGz0+1YFHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KdWFEUET4DkvYQTfdrah4xGIg8dR5nY0Sg2B4r/OZQvItecZjEuWf+piBKhRfvt1byvbiPmKK7zL8Z+d2J5Z+Uy3tSK7Hc7YChVuAEX9kkY42YvRPZSFtikSJUB6sun0Zp5Ri1XaxaRRUmu6Va7NUruj610Z2DAfrZLGhL4C5Us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=yga8CgaW; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=aIgZ+a+S; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="yga8CgaW";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="aIgZ+a+S"
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626FLMW01309680
	for <bpf@vger.kernel.org>; Fri, 6 Mar 2026 17:22:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=pr4Nfzb0emZZfAuLJ5HVEeENsiRdMnyg1bAl5iGzHG0=; b=yga8
	CgaWCm1Yr67rb1gSNLwgptixn8IOIaLwAGFZpDBxoRKDPDULtIMSHChurJG6EsKJ
	IrymWEF/Qt9HZcvSL81AQAMPeFFEJoLnIjUJDV9mz9e7hu1LPshLi6ft58BQKnMI
	oAyN+nhSYMUJxjkxhdpiLRwevWO66sN5LYXIC28kjiTUScYDYfcJiuV+6lgj6n0h
	+LfX23tYxwGe4ec6kUdWIsZYeMGetkhPnviD0MlnLY1cjI0HPlp3Y0ZStxQ5oc2f
	uNqI7eVvU+jaCbJ13Jez0YIv99QUzJwGQ+0G5RA53KVxmOJtw576A91PH4FhRYmM
	m8KOXKVCQYXVJSaS7w==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4cphtpcsph-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 17:22:40 +0000 (GMT)
Received: from 04WPEXCH012.crowdstrike.sys (10.100.11.82) by
 04WPEXCH007.crowdstrike.sys (10.100.11.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 6 Mar 2026 17:22:38 +0000
Received: from mail-yw1-f198.google.com (10.100.11.78) by
 04WPEXCH012.crowdstrike.sys (10.100.11.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 6 Mar 2026 17:22:38 +0000
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7987861595eso172365567b3.1
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 09:22:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772817758; cv=none;
        d=google.com; s=arc-20240605;
        b=W04XCPvAMA/mV782+dFjzwDTSaNTnmu8/QZEu6KZYY8TM4ioEMEdoHichEg/3b+g3l
         8iPThc60aBXjAyR6shsUHbaiG+BZccHtXZwbzFEx989FUrs9yO7kuBTWNmLKejwfdOBq
         nRZSzkgfcI17b5B0pPVIzU23pl3A5OPhmxa7VFbFIzC96ZyBGytD0nNHsAifCjZzi6o1
         0p0+2/ggu4K9i6RZIiI0iuDW9D6GHITQvbmgEiO1ibqntljtuJIfX2UpzZRhGHWuCLns
         He6j1rbhJQlwF6pKwEa8NZQAa3byh7vJ5NfZ9H603MXmkne/tuA6PIvypLFM4qIiGOdV
         rDqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pr4Nfzb0emZZfAuLJ5HVEeENsiRdMnyg1bAl5iGzHG0=;
        fh=OuLyp9pHqMp3gUvmLIwYM96VcEjEi45iV/8gr/T5VG4=;
        b=GexBHzT9E7+49e+yAMWLOV0suroVwukF+3R/4yIlxG7fAK4iQLbLuCyqIU/0a/dLAU
         9eB/gt43PcH/GIqoW1n4qh1FCZqYBUCc2wMMs4csBh+vIvBcXPwCsc2VKvXGCHx06Br0
         tWyXayNjSoTB/WFL3dqQioQgFb3H1d3icEGmr9ObenmZXTCm1OlxycbC3NJC6zRkry9N
         JdPVzAmK7uwFa/5y6qpRkLZd+aQCxFue7VVTQcWDHi/bFU4dCXUfkd08HLVLufj7Dtow
         we8LWP96SsOgrUn/0XS8TylVkuvYx5j2ypJBxOh5ZZVyprgwvKrtL7j5tCDDPXiwZPK+
         npxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1772817758; x=1773422558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pr4Nfzb0emZZfAuLJ5HVEeENsiRdMnyg1bAl5iGzHG0=;
        b=aIgZ+a+SgtcZs0aIigT2UNenuKyJ3bGZG2VB1BUmHxsE6OpH7uMnFHYGFd/lhCSiW0
         3+vhEDQjnSP2zAwdsGF2gQnlcY0kWolETWBCb9z7Kzx36zWnsnFvtu3tkxhOg0+eX5Fa
         RoiqqzK5uD9faTFhZMIUTqiKLw0VgGtoY9EYuqcLflaghsMU4jOcov1oz6cP2dlZ/Z2U
         Zp82jXmEJwsGN60Y8FlHFMhIKefUtSJbv0CgoonOIAaqXPS8zhq+ukD8SsoBCbLhUX2N
         FbvfN6qY2HZGDnloeeT6nKS/YwFwjh6U83xrbzkKHWPYAsdaLEmmdgEf8f5jbM6ZsJIX
         fhLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772817758; x=1773422558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pr4Nfzb0emZZfAuLJ5HVEeENsiRdMnyg1bAl5iGzHG0=;
        b=h/tSl+wCf9pN7X8Q76bld2q9+ceXRVphHnrkqAzm8e6uRIVgIU1fz4JoMZgeFR0UEx
         iloervHsRCpzluDyTveDzJT2anAxEoL4ec4uSWAmn5Tv6HqyaVD56H1w9ij8bS1zxQWp
         DgAlUh9PPSRDmxln39jwdcmRf31AC6m/dT0ghZClyoE33R05y3/qnXcOtchIQttYPzhi
         XYCXoALV4kaRn+wTHrJnlTsVWMvzrjtDk7igIpbgeofTw3TpHlBCV5uYA85Kqiv+6Hkn
         g79XlbK/qzWqUq9aNOSakCIUNKhUMHx/Uq1D+c1zgJggxlOmlwu6R/DP4WociBSSU2l2
         38Vw==
X-Gm-Message-State: AOJu0YxpZ90+GYwkXZQz4dqjTf8zGuMCTATNUZlJloMXRYavVXUV53aU
	h212I6bg46B8/J2pNDmAYwa6AlGmMv/fKg2s+qTYBpTnJeEH+49oXjJjqBx0mXq6bDmTlXYpPBW
	3Xz8wl7ZkwSBfCZDbTboyyLnfJgLuIhY26Avi0bPGG/M6lsnNLCAs+IBCYUlcbAwXxDc8fVkWRc
	wQWlGTisxKUQlgar7gcsacr4G/Opl+BqcegF7SstfLC98=
X-Gm-Gg: ATEYQzze1HipI/pCQdIDhdVa0XkGcDyoemdAVaPsg651cLZt2S7IzrdPH05q1R40Dil
	1GhsjTFNW92rklByHg7/Zop/Siv/pT54P926PH5LSDc15XLuxFm+eC0i9rgAiOqWND4lp3AcZDQ
	+cXd2L2Xm0dCbgKH7YgVLQvvXiD65m7eRPtXCw7/5auw+sTDYmxxOZce+plgiWcGiYUe9ETSUvz
	X8a
X-Received: by 2002:a53:e196:0:b0:649:d492:cb35 with SMTP id 956f58d0204a3-64d1429cb47mr2024174d50.56.1772817757538;
        Fri, 06 Mar 2026 09:22:37 -0800 (PST)
X-Received: by 2002:a53:e196:0:b0:649:d492:cb35 with SMTP id
 956f58d0204a3-64d1429cb47mr2024141d50.56.1772817756833; Fri, 06 Mar 2026
 09:22:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-veristat_prepare-v2-0-15bff49022a7@meta.com> <20260220-veristat_prepare-v2-1-15bff49022a7@meta.com>
In-Reply-To: <20260220-veristat_prepare-v2-1-15bff49022a7@meta.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Fri, 6 Mar 2026 12:22:26 -0500
X-Gm-Features: AaiRm52vZFDce7tmcGNy6q9bw6b9l63MN9-zruVouJ8KWxkwcDDQHsRWCPI8K-w
Message-ID: <CAOu3gNgW9+C7bOPkt0CGs8d_ad_TNyQ0AKv7_Jfg4=F5PET4ow@mail.gmail.com>
Subject: Re: [External] [PATCH bpf-next v2 1/2] libbpf: Introduce bpf_program__clone()
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@meta.com,
        DL Linux Open Source Team <linux-open-source@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Disclaimer: USA
X-Authority-Analysis: v=2.4 cv=BLO+bVQG c=1 sm=1 tr=0 ts=69ab0d60 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=KZhmPCYDdY0A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22 a=b3B37AjAgz0HnGB3MuNd:22
 a=VwQbUJbxAAAA:8 a=pl6vuDidAAAA:8 a=Pgacwa0oAAAA:8 a=pGLkceISAAAA:8
 a=VabnemYjAAAA:8 a=1IjWb1a1_34_N8eyDh0A:9 a=QEXdDO2ut3YA:10
 a=xnLNWz09G3ZUmE6K9NTY:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: gIKK2rVXVzdBh4YyoUld1dsUnEsaiLef
X-Proofpoint-ORIG-GUID: gIKK2rVXVzdBh4YyoUld1dsUnEsaiLef
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE2NCBTYWx0ZWRfX826QmbDdYwyv
 5nNFwTMZ6KLixA996qxTsJlONVJ2cTjRGzp9GgC+GrDx4kAQaf/eTvN9IvhsGHAXzCVfQYWzwUi
 Iqb9vvAYDHV6LCS+EXHw/MzDxYQ0pnZl1A+NMUYw+7q+fBf+QKE156ifI+ENF9uXBM2dWZ1q8rO
 7etdi0d81SSDPcBHzteANsJVP7EuZ/oYC9Qm3aHtU55qLIXM1bzAYTtXkabgktR8E65ZsZ8G3jt
 pRQKnw6lrH0dPGdXJiYyIS+50Buwjx12L/43fFdSyoygw5+nO2lGgcgUfBFebAGGnTUtT9VB39M
 UMiFP/GZAxOrm17HzPLiuL52gPGD68E+astI/TEl0tusECqxnDaJOz7m1HG7fpyPUcDz5kT47qm
 lyfPuzjFMTi4vBUcLLEmD5HuV9eqtqpGSeqHV5bFJ75jtEw0RMmtusRPMB1LRKsYgjHxOGwooCt
 TfJcOvypAY/mvWl/vkQ==
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11721
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060164

Mykyta and Andrii Hi!

We're evaluating the bpf_object__prepare() +
bpf_program__clone() API for use in a production BPF
application that manages hundreds of BPF programs with
selective (dynamic) loading =E2=80=94 some programs are loaded at
startup, others loaded/unloaded at runtime based on feature
configuration.

We have a few questions about the intended usage and
potential extensions of this API:

1. Compatibility with bpf_object__load() and object state

After bpf_object__prepare(), the object is in OBJ_PREPARED
state. Several libbpf APIs (e.g., bpf_program__set_type())
gate on OBJ_LOADED state.

Is there a recommended way to transition the object to
OBJ_LOADED after cloning all desired programs? For example,
would a bpf_object__finalize() or similar API that runs
post_load_cleanup() and sets OBJ_LOADED be in scope? This
would allow users to benefit from prepare() + clone() for
selective loading while keeping the object in a state that
the rest of libbpf expects. Or, is the new API not intended
to work with bpf_object in the first place ?

2. Storing the clone FD back on struct bpf_program

bpf_program__clone() returns a caller-owned FD, but APIs
like bpf_program__attach() read prog->fd internally.
Without a way to set the FD back on the program struct, the
caller must reimplement attach logic (section-type dispatch
for kprobe, fentry, raw_tp, etc.).

Would a bpf_program__set_fd() setter (similar to the
existing btf__set_fd()) be acceptable to store the clone FD
back, making bpf_program__attach() and related APIs usable
with cloned programs?

3. Use case: selective program loading from a single BPF
 object

Our use case involves a single large BPF object (skeleton)
with hundreds of programs where a subset is loaded at
startup and others are loaded/unloaded dynamically based on
runtime configuration. The current approach requires either:
- Loading all programs upfront (wasteful), or
- Maintaining out-of-tree patches to libbpf for selective
loading

Last year we made an attempt to upstream our solution to
this use case to libbpf[1] but Andrii pointed out how our
approach was problematic for upstream. He then proposed
splitting bpf_object__load() into two steps:
bpf_object__prepare() (creates maps, loads BTF, does
relocations, produces final program instructions) and then
bpf_object__load().  We are trying to follow up on his
input and become more upstream compliant.

The prepare() + clone() API seems similiar to this,
but the questions above about object state and FD ownership
are the main gaps for production adoption. Are there plans
to address these in future revisions, or is this
intentionally scoped to testing/tooling use cases only?

Thanks,
Andrey

[1] -https://lore.kernel.org/all/20250122215206.59859-1-slava.imameev@crowd=
strike.com/t/#m93ec917b3dfe3115be2a4b6439e2c649c791686d

On Fri, Feb 20, 2026 at 2:18=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Add bpf_program__clone() API that loads a single BPF program from a
> prepared BPF object into the kernel, returning a file descriptor owned
> by the caller.
>
> After bpf_object__prepare(), callers can use bpf_program__clone() to
> load individual programs with custom bpf_prog_load_opts, instead of
> loading all programs at once via bpf_object__load(). Non-zero fields in
> opts override the defaults derived from the program and object
> internals; passing NULL opts populates everything automatically.
>
> Internally, bpf_program__clone() resolves BTF-based attach targets
> (attach_btf_id, attach_btf_obj_fd) and the sleepable flag, fills
> func/line info, fd_array, license, and kern_version from the
> prepared object before calling bpf_prog_load().
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/lib/bpf/libbpf.c   | 64 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  tools/lib/bpf/libbpf.h   | 17 +++++++++++++
>  tools/lib/bpf/https://urldefense.com/v3/__http://libbpf.map__;!!BmdzS3_l=
V9HdKG8!3OeUmMPxKbEw0Wl_ZYw9yzRwdxA2X7kuWyzFOxvKuIsQg1fhhJtfaqSd4n0N6UokYqO=
uQporDXrIKYc3k7dvu4Rel1BiJSjA99yzJZk$  |  1 +
>  3 files changed, 82 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 0c8bf0b5cce4..4b084bda3f47 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9793,6 +9793,70 @@ __u32 bpf_program__line_info_cnt(const struct bpf_=
program *prog)
>         return prog->line_info_cnt;
>  }
>
> +int bpf_program__clone(struct bpf_program *prog, const struct bpf_prog_l=
oad_opts *opts)
> +{
> +       LIBBPF_OPTS(bpf_prog_load_opts, attr);
> +       struct bpf_prog_load_opts *pattr =3D &attr;
> +       struct bpf_object *obj;
> +       int err, fd;
> +
> +       if (!prog)
> +               return libbpf_err(-EINVAL);
> +
> +       if (!OPTS_VALID(opts, bpf_prog_load_opts))
> +               return libbpf_err(-EINVAL);
> +
> +       obj =3D prog->obj;
> +       if (obj->state < OBJ_PREPARED)
> +               return libbpf_err(-EINVAL);
> +
> +       /* Copy caller opts, fall back to prog/object defaults */
> +       OPTS_SET(pattr, expected_attach_type,
> +                OPTS_GET(opts, expected_attach_type, 0) ?: prog->expecte=
d_attach_type);
> +       OPTS_SET(pattr, attach_btf_id, OPTS_GET(opts, attach_btf_id, 0) ?=
: prog->attach_btf_id);
> +       OPTS_SET(pattr, attach_btf_obj_fd,
> +                OPTS_GET(opts, attach_btf_obj_fd, 0) ?: prog->attach_btf=
_obj_fd);
> +       OPTS_SET(pattr, attach_prog_fd, OPTS_GET(opts, attach_prog_fd, 0)=
 ?: prog->attach_prog_fd);
> +       OPTS_SET(pattr, prog_flags, OPTS_GET(opts, prog_flags, 0) ?: prog=
->prog_flags);
> +       OPTS_SET(pattr, prog_ifindex, OPTS_GET(opts, prog_ifindex, 0) ?: =
prog->prog_ifindex);
> +       OPTS_SET(pattr, kern_version, OPTS_GET(opts, kern_version, 0) ?: =
obj->kern_version);
> +       OPTS_SET(pattr, fd_array, OPTS_GET(opts, fd_array, NULL) ?: obj->=
fd_array);
> +       OPTS_SET(pattr, token_fd, OPTS_GET(opts, token_fd, 0) ?: obj->tok=
en_fd);
> +       if (attr.token_fd)
> +               attr.prog_flags |=3D BPF_F_TOKEN_FD;
> +
> +       /* BTF func/line info */
> +       if (obj->btf && btf__fd(obj->btf) >=3D 0) {
> +               OPTS_SET(pattr, prog_btf_fd, OPTS_GET(opts, prog_btf_fd, =
0) ?: btf__fd(obj->btf));
> +               OPTS_SET(pattr, func_info, OPTS_GET(opts, func_info, NULL=
) ?: prog->func_info);
> +               OPTS_SET(pattr, func_info_cnt,
> +                        OPTS_GET(opts, func_info_cnt, 0) ?: prog->func_i=
nfo_cnt);
> +               OPTS_SET(pattr, func_info_rec_size,
> +                        OPTS_GET(opts, func_info_rec_size, 0) ?: prog->f=
unc_info_rec_size);
> +               OPTS_SET(pattr, line_info, OPTS_GET(opts, line_info, NULL=
) ?: prog->line_info);
> +               OPTS_SET(pattr, line_info_cnt,
> +                        OPTS_GET(opts, line_info_cnt, 0) ?: prog->line_i=
nfo_cnt);
> +               OPTS_SET(pattr, line_info_rec_size,
> +                        OPTS_GET(opts, line_info_rec_size, 0) ?: prog->l=
ine_info_rec_size);
> +       }
> +
> +       OPTS_SET(pattr, log_buf, OPTS_GET(opts, log_buf, NULL));
> +       OPTS_SET(pattr, log_size, OPTS_GET(opts, log_size, 0));
> +       OPTS_SET(pattr, log_level, OPTS_GET(opts, log_level, 0));
> +
> +       /* Resolve BTF attach targets, set sleepable/XDP flags, etc. */
> +       if (prog->sec_def && prog->sec_def->prog_prepare_load_fn) {
> +               err =3D prog->sec_def->prog_prepare_load_fn(prog, pattr, =
prog->sec_def->cookie);
> +               if (err)
> +                       return libbpf_err(err);
> +       }
> +
> +       fd =3D bpf_prog_load(prog->type, prog->name, obj->license, prog->=
insns, prog->insns_cnt,
> +                          pattr);
> +
> +       return libbpf_err(fd);
> +}
> +
>  #define SEC_DEF(sec_pfx, ptype, atype, flags, ...) {                    =
   \
>         .sec =3D (char *)sec_pfx,                                        =
     \
>         .prog_type =3D BPF_PROG_TYPE_##ptype,                            =
     \
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index dfc37a615578..0be34852350f 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -2021,6 +2021,23 @@ LIBBPF_API int libbpf_register_prog_handler(const =
char *sec,
>   */
>  LIBBPF_API int libbpf_unregister_prog_handler(int handler_id);
>
> +/**
> + * @brief **bpf_program__clone()** loads a single BPF program from a pre=
pared
> + * BPF object into the kernel, returning its file descriptor.
> + *
> + * The BPF object must have been previously prepared with
> + * **bpf_object__prepare()**. If @opts is provided, any non-zero field
> + * overrides the defaults derived from the program/object internals.
> + * If @opts is NULL, all fields are populated automatically.
> + *
> + * The returned FD is owned by the caller and must be closed with close(=
).
> + *
> + * @param prog BPF program from a prepared object
> + * @param opts Optional load options; non-zero fields override defaults
> + * @return program FD (>=3D 0) on success; negative error code on failur=
e
> + */
> +LIBBPF_API int bpf_program__clone(struct bpf_program *prog, const struct=
 bpf_prog_load_opts *opts);
> +
>  #ifdef __cplusplus
>  } /* extern "C" */
>  #endif
> diff --git a/tools/lib/bpf/https://urldefense.com/v3/__http://libbpf.map_=
_;!!BmdzS3_lV9HdKG8!3OeUmMPxKbEw0Wl_ZYw9yzRwdxA2X7kuWyzFOxvKuIsQg1fhhJtfaqS=
d4n0N6UokYqOuQporDXrIKYc3k7dvu4Rel1BiJSjA99yzJZk$  b/tools/lib/bpf/https://=
urldefense.com/v3/__http://libbpf.map__;!!BmdzS3_lV9HdKG8!3OeUmMPxKbEw0Wl_Z=
Yw9yzRwdxA2X7kuWyzFOxvKuIsQg1fhhJtfaqSd4n0N6UokYqOuQporDXrIKYc3k7dvu4Rel1Bi=
JSjA99yzJZk$
> index d18fbcea7578..e727a54e373a 100644
> --- a/tools/lib/bpf/https://urldefense.com/v3/__http://libbpf.map__;!!Bmd=
zS3_lV9HdKG8!3OeUmMPxKbEw0Wl_ZYw9yzRwdxA2X7kuWyzFOxvKuIsQg1fhhJtfaqSd4n0N6U=
okYqOuQporDXrIKYc3k7dvu4Rel1BiJSjA99yzJZk$
> +++ b/tools/lib/bpf/https://urldefense.com/v3/__http://libbpf.map__;!!Bmd=
zS3_lV9HdKG8!3OeUmMPxKbEw0Wl_ZYw9yzRwdxA2X7kuWyzFOxvKuIsQg1fhhJtfaqSd4n0N6U=
okYqOuQporDXrIKYc3k7dvu4Rel1BiJSjA99yzJZk$
> @@ -452,6 +452,7 @@ LIBBPF_1.7.0 {
>                 bpf_map__set_exclusive_program;
>                 bpf_map__exclusive_program;
>                 bpf_prog_assoc_struct_ops;
> +               bpf_program__clone;
>                 bpf_program__assoc_struct_ops;
>                 btf__permute;
>  } LIBBPF_1.6.0;
>
> --
> 2.47.3
>
>
