Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.148.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793395784;
	b=r6lI6qz2UYpLWGv+Ab9scKCgX6ialRE+IgZHKdzUWed5uYmeDvKlc0Gz+YUAmlBlNcAN
	 KE5hJ6ldyEIvS0hwqj0MpNK/1B5lL1L/R4ev9W1vpKdSv6NixQU2Sj2hcX1rueAGGT66T
	 RMDWqrytok70KyjY7RqTbvvKYrYXj5/Ngd3pQmt35Rivr+RepBXuRUEz/ZSG1oF5dta5T
	 +szZCCBeWP1W+a64CSnEytgZFBRkTW+vqE1uyavTOo/F8he3+fbLx9SuAwOR0G9M9v8i5
	 bPeAIMN2hXewPBo1SQN2gOon8Gm9W3xkPub+Byjia3bMmNd2EtVXiiEiR7JpIbEzJVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395784;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=9zxGIXw894w7HJQDU26JfaxjpQaN+WsRBjyLIF8ZILQ=;
	b=p/N42amX2ovO/sycuoJeH5y+u/QOYlFXb5ugxUhbAYbOW0a4yitej0i5FBRMfdQufe4L
	 QBOVghWsEK6vzp291DprQ/rc2LBJCn/FxdydZDx+58xH71KM6LHcsRWxE+szXkfImf/KK
	 qxDBgDCzWe8s/BoVnvVDPlsAYbS68oujZKHwuV784gsUSO3ZivESKmXITIH/sHU0SxnsZ
	 joZNH1sD2lh2AG5+OmiPwT/ZeUbRxTG9gvLUmaMHmomocyEw2PaDmtx7d2RpolaLp6ndk
	 NlfZ1SQWN39E7fA0iRkm0ZOG29BiMIN557xcd1+F7+YZhMP9U7qlxiG5+ZuUmaFyXlQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crowdstrike.com;
	spf=pass smtp.mailfrom=crowdstrike.com;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=e45vq5Dp;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=google header.b=G3Sy9sU2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.148.77
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469E0606A31D
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 21:29:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 469E0606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=e45vq5Dp;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=google header.b=G3Sy9sU2
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UL8HpZ3154522
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 21:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=9zxGIXw894w7HJQDU26JfaxjpQaN+WsRBjyLIF8ZILQ=; b=e45v
	q5DpOuUJGo3N3ZvE9PVQdiiG6Gwy4gUuyT+/H9LHoCIJEojs7Pom6rMq+WwJJ+l1
	v4uM1prlwUUNFVB1/1yh6Yxpq63ITYVCkfRyLtj4zGqeYZyDdckzqnt2ihHKcJVx
	nGODESy8tfTBeQDgOR9wILilwwxZs6Ut4vPgolBdrhxtyA0by5hwQTh1KlOU6/k+
	IscOl3PRjgX7U/zMrrvERkSlYS0vGRsomscClJ7osJLX8RVguMHjo4ygWTgKxh4r
	ykXeImSghH1QhKdH1k5fAREpbSkBZquFmUAelCLXIMoZR1VQBJV5Nyolyp9qSPc2
	1G4daR5oUeFSr2EP5Q==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4hn2vy023s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 21:29:43 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-8b04ea2d440so18799327b3.2
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 14:29:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793395782; cv=none;
        d=google.com; s=arc-20260327;
        b=H5NIPDbOjn5YeScVCKG9c6At9x4x4STIiCEl7NeriLNFezri+envnB/vH6Grsu/NZ1
         gUQqmEok5OBATB4/91TASjClHaxseDhYEmw/GjwhUTuNiZqOPno63qBadCA+KCpdQi51
         rY0vBOHyMDIfwkls46sspJ+NW728GcTD36PmxMc82HNsSSgq6JSqVfeHh5dmZww0qMfe
         oa1pb3NUwk8lJd1mFfkJ1IsfflXH5j3L6TzfN5rRMAWxgFKc421zSAxhetZc52IqfCNP
         FZjgXzEzJBuATyulSzUbwU9vbNvBzsqVBZOM/1P49RtQDlDeTzJsVKvyK1V258CSFzmj
         Gmxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9zxGIXw894w7HJQDU26JfaxjpQaN+WsRBjyLIF8ZILQ=;
        fh=zxca8D0yP/A58Gmh/uG4ojyhu1MM8SPLKRaDXn52Dzg=;
        b=pPMW104AXMD6b03+WKG4G0BP5At11QseqS2CqwCryAP4aJoynedCX8EPDLiMqFO/yn
         xXNV9sttDAHPhi2j8QdGn4zz2plNchLs+PXxymt6FenSWDE2XVnTxYCdNDoD7l0g8I5r
         0kIBmCh2Q5TbhSNpSmtaLEox5c/GsHGcKkXuTkEOYyloATZGylvCs8q3BDeKD6mnUyT2
         iTnlaCGECNzYN5+z1mxfY7DRIs+H9sgpGL56uzy5yf5e1+lyT06PPP1lSJvf9Inl+nsu
         VxUepu6tF5WmTDNnxasJJo5qCAMZp6WxCRj8qxttZh3K0nOzQlKQQci+jPoGJGeROe4L
         Q3UQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1793395782; x=1794000582; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9zxGIXw894w7HJQDU26JfaxjpQaN+WsRBjyLIF8ZILQ=;
        b=G3Sy9sU2SLscoXC3SRgxOfZGltm9O1iqB2pNvC+DyRTIBI+KXYEOmLiCikk8a9H9C6
         JEqkZgzgOCK8DTHkQ3NE5EXZxpXb/LRIKWhPbIqdfDqdK0Z0Wa10bUJB3EZSTqXRe1ve
         MxdHO9ScjTX8M+4MoXyXROQ1AVUyISr1dMU06iQDj7e7X1mY25dRhT6FoESxwN1dIWJF
         7PvHZfol9lwDayKlIEcuARbVq/NYyS7RUcayn2qRO22O5fmSapQCV6YJnvEPUmwAU0+C
         /1ybs/2qAiumCDW5he9fkjvoI1YaoEhIqS1l8UGGHGtoMgtzqhANnNxVb00LiG4javhl
         yYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395782; x=1794000582;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9zxGIXw894w7HJQDU26JfaxjpQaN+WsRBjyLIF8ZILQ=;
        b=iBlWnFadH3+6XpDuyZzCoDzm2I0jpD6uTJhrtbCY4EieM4qPf4uqKE7q6kRaHYDcxm
         E9vnD2yK2Xd8j/SaBJK6ZRVsV6s+/Gf/9rhZFFOMpGsDZHX2uxAiMBk4/JZQOgegRQOQ
         nI1tsXRpPFbrfB1VdouedO5pq5InTgLI0YWVBvEY93Xk9QZctCCbr5X+R3bYBdN+AIRh
         ydevNuegRo71MSFJ0jcUzYcN4pdTuaqIY6jvBu9UYwR+ifvUr25d6FIwnokMvWQTn522
         g0AhxIrgcKFZBJ5KRnolStl9iMdYcz0JhjibxBYjoateH9FuTisuXWz1hAE15s/Gx6wh
         7vvQ==
X-Gm-Message-State: AFq9FYJFPqK/MJIufoE5NVROkLGHLxL2Tr0JwwEWuUX9b8xN/YsQefYP
	zWWsh/FLpIA26IQItnjsMKw7Ibe0W33oehH/yuk/AZzEtr0hjQtgT9txL2L+YbE3UY7McTm1DJH
	fHo1pvR6btbsyk4wG+R6iZ8hiOZPMrcFkFykc6PRDf4UDJYILdJDB5cdMYgL+tVaL9Vu5kCuczs
	bz5Msut84k4oac+/Yg1j8LiSTZQhoX
X-Gm-Gg: AYBFou00CvaEFwfrSJBx9AtqRqJBXm7/+LnxHvP6uMLuXtSgfU8W8u4n2oL95uTRsRQ
	FJ84lyc/F7CZQWpnlyLjR3pCKEguxySs1aQZ0IaV4ljbqL98FD+/C5ZUMozLNBL1Gm/8L6FoDOJ
	RL9pOQ3q/79oIm1X+LPu1bLaFFdYbdef7Zd4HHGSK5121ExkCFLL0tJGe0
X-Received: by 2002:a05:690e:168d:b0:676:2898:e43e with SMTP id 956f58d0204a3-67ba4f275d0mr2279537d50.58.1793395782282;
        Fri, 30 Oct 2026 14:29:42 -0700 (PDT)
X-Received: by 2002:a05:690e:168d:b0:676:2898:e43e with SMTP id
 956f58d0204a3-67ba4f275d0mr2279491d50.58.1793395780925; Fri, 30 Oct 2026
 14:29:40 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029223348.3730738-1-andrey.grodzovsky@crowdstrike.com>
 <20261029223348.3730738-5-andrey.grodzovsky@crowdstrike.com> <CAEf4BzZrEOFm5014E20bs0W_9ic7shx8LVkV3jP-zS7bFhJ1fg@mail.gmail.com>
In-Reply-To: <CAEf4BzZrEOFm5014E20bs0W_9ic7shx8LVkV3jP-zS7bFhJ1fg@mail.gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Fri, 30 Oct 2026 17:29:29 -0400
X-Gm-Features: AclHuK8Jff57kFT04o94E9HWeihXpoggCDdJQSU27UN-l7oXmkZR2pRH-Q5JI0Q
Message-ID: <CAOu3gNhnhUETsiwVCaS-gjrtGvMmNuyz91K73q0oHJWP4+Hk0Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 4/7] libbpf: BPF programs manual loading and attaching
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        martin.kelly@crowdstrike.com, slava.imameev@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: yqi22Z9cccz3DvTwU24_q5VkzBRw0fFE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4NSBTYWx0ZWRfX7MCq04gUELvH
 fd/dzmShfi3/C/hZYi99ILvM/oM5G0kBvpmbGjVPTwLmldLY9Bhqe/ZvYFy1cMotum73MHmAg+f
 WQps2DgPX/Efp8F354U8/Ign9AY615YBN/NX5UKwJSJApbBownNN
X-Authority-Analysis: v=2.4 cv=QszLTlyd c=1 sm=1 tr=0 ts=6ae50c47 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=b3B37AjAgz0HnGB3MuNd:22 a=Pgacwa0oAAAA:8 a=pGLkceISAAAA:8 a=pl6vuDidAAAA:8
 a=F1lezQbnwXWAqZpzRrAA:9 a=QEXdDO2ut3YA:10 a=MFSWADHSvvjO3QEy5MdX:22
 a=xnLNWz09G3ZUmE6K9NTY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4NSBTYWx0ZWRfX2sQbzNTRdvFB
 EcxaJFoLcNUiR7uG6vFErK5RwxzfNS7vyn4SPEcM1SS7VFU4IIN+yXLsJUumo/cctkpPLzmj7wR
 s1NdkQHL+qeH+LEV8QiFvKY8XhpOPKrgBbr0ERzDWUqotfvIrVpUjrJ7LWvzZ4hp72ROaBPn+3l
 HgPAN5MYREyF2e7j3fw3Kg7ayJeBw6B5nDu6UgxygYlFUloTLNOlqXrfSuFxAlt2avag+SS7k83
 N/mhc+IoFWa17hGW5dfw1nqG5c8vxJUBSq1VJv5PGIsDF4Pws8V1ZJupOXYdRBCu/NqwKEI7q6v
 Zt7DpwDUMuozGmZ5NnkPeESXoun8T4JNEcU0kvTrVrWAGNtd3mhOztwPCtabP/HaAL+UAE8tFX0
 a/uOWPbOmMmYHpJkB5+TkTqqyK9bqSwm/6gD59d/OUSW6//RwW8AoDtVwqUxgP7z5TnL/UG6NqS
 w+TxB4/I5lnvEkgmcmw==
X-Proofpoint-ORIG-GUID: yqi22Z9cccz3DvTwU24_q5VkzBRw0fFE
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11951
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610300085

On Fri, Oct 30, 2026 at 2:33=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Oct 29, 2026 at 3:34=E2=80=AFPM Andrey Grodzovsky
> <andrey.grodzovsky@crowdstrike.com> wrote:
> >
> > From: Slava Imameev <slava.imameev@crowdstrike.com>
> >
> > BPF programs designated as manually loaded can be loaded and
> > attached independently after the initial bpf_object loading and
> > attaching.
> >
> > These programs can also be reloaded and reattached multiple times,
> > enabling more flexible management of a resident BPF program set.
> >
> > A key motivation for this feature is to reduce load times for
> > utilities that include hundreds of BPF programs. When the selection
> > of a resident BPF program set cannot be determined at the time of
> > bpf_object loading and attaching, all BPF programs would otherwise
> > need to be marked as autoload, leading to unnecessary overhead.
> > This patch addresses that inefficiency.
> >
> > A manual-strategy program is loaded via bpf_program__load()
> > and unloaded via bpf_program__unload(). It only requires that
> > bpf object is already in PREPARE state (BTF loaded, maps created,
> > relocations applied) rather than requiring a full bpf_object__load().
> > Manual programs are skipped by the object's own autoload pass.
> >
> > A few key changes described below:
> >
> > gen_loader is rejected if any manual program is present since
> > this loader is finalized during bpf_object__load()
> > and so it will miss any manual programs loaded later.
> >
> > Two program log related APIs were relaxed to work post OBJ_LOADED
> > state to fix regression where verifier logs were lost in case of
> > bpf_object__prepare failure. It makes sense to relax those for MANUAL
> > programs as they can load post OBJ_LOADED state so the log buff still
> > can be set at this point. Also add proper documentation to the setters.
> >
> > Failures with BPF_PROG_TYPE_STRUCT_OPS were encountered and so in sever=
al
> > places code related to struct_ops logic was altered to take into accoun=
t
> > struct_ops program with MANUAL strategy set. The general idea is to rej=
ect
> > this type of programs for manual loading since those programs cannot
> > load/unload independently of each other per a given struct ops.
> > Hence, SEC("!...") style declaration is rejected for them while
> > bpf_program__set_load_strategy() does accept them to allow certain
> > flexibility in the API future usage.
> >
> > Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
> > Co-developed-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> > ---
> >  tools/lib/bpf/libbpf.c   | 194 ++++++++++++++++++++++++++++++++++-----
> >  tools/lib/bpf/libbpf.h   |  51 ++++++++++
> >  tools/lib/bpf/https://urldefense.com/v3/__http://libbpf.map__;!!BmdzS3=
_lV9HdKG8!0gp2jpynFtDmlMXbHY-9o84laRuxs_GnQfh8fp_k0R57DvyBHRQpxFCJeaeCWGZPN=
2KHa8pZMxGgByb_P1tyaKN3-GDIoiZ7vjboow$  |   1 +
> >  3 files changed, 225 insertions(+), 21 deletions(-)
> >
>
> [...]
>
> >  static int bpf_object_prepare(struct bpf_object *obj, const char *targ=
et_btf_path)
> > @@ -10038,7 +10137,8 @@ static int bpf_object_prepare(struct bpf_object=
 *obj, const char *target_btf_pat
> >                 return -EINVAL;
> >         }
> >
> > -       err =3D bpf_object_prepare_token(obj);
> > +       err =3D bpf_object_check_gen_loader(obj);
> > +       err =3D err ? : bpf_object_prepare_token(obj);
> >         err =3D err ? : bpf_object__probe_loading(obj);
> >         err =3D err ? : bpf_object__load_vmlinux_btf(obj, false);
> >         err =3D err ? : bpf_object__resolve_externs(obj, obj->kconfig);
> > @@ -10121,7 +10221,7 @@ static int bpf_object_load(struct bpf_object *o=
bj, int extra_log_level, const ch
> >                         err =3D bpf_gen__finish(obj->gen_loader, obj->n=
r_programs, obj->nr_maps);
> >         }
> >
> > -       bpf_object_post_load_cleanup(obj);
> > +       bpf_object_post_load_cleanup(obj, false);
>
>
> for consistency please add /* !force */ next to false in a follow up
>
> >         obj->state =3D OBJ_LOADED; /* doesn't matter if successfully or=
 not */
> >
> >         if (err) {
>
> [...]
>
> > @@ -16286,10 +16393,26 @@ void bpf_object__destroy_skeleton(struct bpf_=
object_skeleton *s)
> >
> >  int bpf_program__set_load_strategy(struct bpf_program *prog, enum bpf_=
prog_load_strategy strategy)
> >  {
> > -       if (prog->obj->state >=3D OBJ_PREPARED)
> > +       struct bpf_object *obj =3D prog->obj;
> > +
> > +       if (obj->state >=3D OBJ_PREPARED)
> > +               return libbpf_err(-EINVAL);
> > +
> > +       switch (strategy) {
> > +       case BPF_PROG_LOAD_STRATEGY_DISABLED:
> > +       case BPF_PROG_LOAD_STRATEGY_AUTO:
> > +               prog->load_strategy =3D strategy;
> > +               break;
> > +       case BPF_PROG_LOAD_STRATEGY_MANUAL:
> > +               if (prog_is_subprog(obj, prog))
>
> this subprog check should be independent of strategy, we shouldn't be
> manipulating subprog load state (it's meaningless). Again, please just
> send a small follow up
>
> > +                       return libbpf_err(-EINVAL);
> > +
> > +               prog->load_strategy =3D BPF_PROG_LOAD_STRATEGY_MANUAL;
> > +               break;
> > +       default:
> >                 return libbpf_err(-EINVAL);
> > +       }
> >
> > -       prog->load_strategy =3D strategy;
> >         return 0;
> >  }
> >
> > @@ -16297,3 +16420,32 @@ enum bpf_prog_load_strategy bpf_program__load_=
strategy(const struct bpf_program
> >  {
> >         return prog->load_strategy;
> >  }
> > +
> > +int
> > +bpf_program__load(struct bpf_program *prog)
>
> hm... why that int is separate from the function, plenty of space
> (nit, but adjust in follow up, please)

Thanks a lot for your (and Alexei's)  time and effort reviewing our
work, we appreciate it. Yes, sending a follow up with all the comments
you made here and in the other patch will be my next task.

Thanks,
Andrey

>
> [...]
