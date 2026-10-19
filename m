Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81BB59E3AC
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 13:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.152.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792418365; cv=pass; b=IXLJ0JyHehmj7L5ES6WcQT2NPWIoOsR+MTa3gEOO/vZk26m40vDu3WlQJqvDtjb0JITJOprV1rWZwN33G+0KYR28wfULFf6HHgt2W5pXC3UgAzwX3Cd8OdHJ7gBh+eBPhcYKc55FcLxMNjjDN+5alLuPpQVVeIsmD4cKZlvec2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792418365; c=relaxed/simple;
	bh=vRKtHhtnSiVocMKcHj2IeE7eoWduJufuBbjw8LUmvyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hx7zY3sY1LIb+D/0gZwS4wGVpCM8RsW4wZ0j4gWW6vMqpdcmVQ37U21JCdy4+xDquoEmBfAIM0FRVpUP+dmOjExyR29JwqBVceTc6dIWtm6Wo66yNHcdymYNT8wmwzCAk7fuGHTtPfurMwbyNbEax+iL22lr07VQsbWtW6ClRrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=dozKaF1m; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=WITz630F; arc=pass smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="dozKaF1m";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="WITz630F"
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69JD9dQQ2561436
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 13:59:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=W2Q5NbkXZFX2IYeB+rITdmJ46kQ40IR/VqtH2S5mst8=; b=dozK
	aF1m//QlqQfhqKEeZH7yccyiI3Zvo2avADGqUzkwKY4/b3qe0U2mMUsMnOgx3t9C
	w8/ahz50BQ20ArJo1kgmpCd4uRJ0qggtT0JMKsGptpIVzqYFp/U+iU5miAvY7zQ9
	fmbFCpCFANtC52fcr0zygGl1FFerSnMCqCQOQJykN38xQVkzRs+MqaXoA8bw0IR8
	DEDJGSGM8I95PEBAWrxYOdvt11dbnYpOO1/xl8C3GNyGT53cun7a4GPBeDGVUdH/
	VJjFFX8RryP4bKDpfZA0WJF4x7V+Ot6NkgIvAKB/8gXSRbPEphCmHFZe6MEH9Y9d
	RgDRrDGDHdZucZlcSA==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com [74.125.224.70])
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4hcktwbbsy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 13:59:16 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-677c4ca2265so2824006d50.2
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 06:59:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792418356; cv=none;
        d=google.com; s=arc-20260327;
        b=gIHe5taTztm8N4bJ/XZUnoVg3zPhWMW38KY0HXl1hPajqfMzxR0enDANM63CiM++Pl
         fEGxR+kMtCpyWYLfiMIyotANKnvKRiZbTZk22ZYDQA7pdbydTPmXXKDx1j0omZQp35PM
         ziqoK7x005DSJYSX+EGGF3LFf7fECXvnbn2E2DcpRCddXk5ONeB7jLzHCrWWHunz/qik
         50jIEVr+cTf8QTBS7KrasLGHF4epE/hjSJhbZEOoMoQU+oqxsdVJ9otbOjB+Fbp2EAGX
         VC1vICDlbs9Ov/GhFoBmcKXBlAVQ4WiH43w5Gt0X5BZGFZk6fvv/f150WgyL6ZNpy1BN
         C6RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W2Q5NbkXZFX2IYeB+rITdmJ46kQ40IR/VqtH2S5mst8=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=YYpJOr5YKslMRlaEBs55mXa5636GzI9t6jIKBft8XG6UKOsR6BjDS6ssOyKkrYOz5u
         FdekZu/FkOj4C11ft+2LUvr/bl72QOgscRbMjv1NOPtGrelLRhTxiCurMPyXsUs1DyRa
         eOmY7JOESTD/fGvpcY7jpehuGEXQ5AGqfuffSZFTA1Vf1cHNcTx7Nf1nx/atmlB8NUk6
         dEut9FAtmVF3tVQyqI33M7qOnXzKrxEIDHi2OhB7Hd9fPy0hqQ6As77SkFA/tUep8T2I
         jtVhOqDhDoanja6CM8qhNbDBJe/lxsWArMWPv2bnfyQKtHvV4c/6dQqtc1WSE/IIZEo0
         N3Ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1792418356; x=1793023156; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W2Q5NbkXZFX2IYeB+rITdmJ46kQ40IR/VqtH2S5mst8=;
        b=WITz630FdWmo3zT1aaXnq/pllyd4MHl8xunzdiGmHjUNYe+asa0Kq06YNvt7QIJjk4
         RL38ecaL8cuYPqcFecbEFXi/LtkZzmtfC1ZHE6YLHEaXKVtXabA9PFo8XOe1VR5AtoPj
         8aNB74h81c2AokSK3wj+E3RGl3iQ+dsfVFa//9rFSpD0ymxbs+sDegh8e9v/oL4qPRIz
         Yv82I8btvKRxWkYTGpPtaDQ3NtKORVkwKgjm9NzWrAOIlHQ99gjZCldGTqP1erGt4y28
         wfyJ/4PP1KU5Rut2SxnxvkuTGCR0/dCmGMaS8u/9esjPPfC4au6HP/Mcj1366/hN4NmS
         SsSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792418356; x=1793023156;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W2Q5NbkXZFX2IYeB+rITdmJ46kQ40IR/VqtH2S5mst8=;
        b=NnAS8gfzYjLGNvs29fanZjvRY1t9IWxkzf7OWZarOK/8tPtLQRw4tYvregoLW0khKL
         U0V2K+X1zgET8UW5QuK/x37/VJPui1ecuGT6mFNcEgOH9aJFKqgJpDDjFYiay1Rwsqpx
         Fzssp9kGCj2Nth6smUUvH47nVi4r3k+BnQLLmUFISiFBTWmPY8K03KVFroaQJimGE3kx
         J27y2G6Vb8ucPbCPiSgnbdYCRuqaaE3n9aIYyLixT4cBk+6vw8MVD44ZNomwDcTrwwVK
         34m9cqwZqDmtIrvcLMUjxUIg9abmHuLU3JOvz6b2eQbqbd5b3UCrRLuzw5yz4roBgrDo
         sRMg==
X-Gm-Message-State: AFq9FYKeimowbfTKxzq/DgjxBLWoOhI/HRlHny/lJ43mlaDpBycg/xSH
	e81QEcyZTIw7/EQXddP1VZeWe/cZ1PCApFWpv7tLfBFCYZ4j/jgdWsj2UQNILfrUGkZWL+PdDS5
	H2iMCDwP1A/fOfBfaKaOC4/8HBrbCH8zo+fSJ7AZMtFO5ytVqmi7Q6ex5IL9kA3g8R9Tzvk5MYc
	nvOxIDsluvl9vVCWanOecYuQ22N8dydryHoxp7
X-Gm-Gg: AYBFou3SuDwUNgCgznG0L8sn7z5z56kkNVQUOFifDIQG+tuRxmq0Vwmx+UrSMQcisNu
	PHK0torh7gxBlc8T0IkEWVADVeEoEmDQJF5zAS9oXyNDgTyIOdZdUz5kGPP0r0JMoiELzdsOZkM
	HfgEIMRgTWzIdJHPSrMTjrt4cSoK34QSKmodduRGOiS6X9UYdi0Pqo6gyo
X-Received: by 2002:a05:690e:1512:b0:679:15d0:9492 with SMTP id 956f58d0204a3-679ca8d61famr1806932d50.93.1792418355953;
        Mon, 19 Oct 2026 06:59:15 -0700 (PDT)
X-Received: by 2002:a05:690e:1512:b0:679:15d0:9492 with SMTP id
 956f58d0204a3-679ca8d61famr1806925d50.93.1792418355387; Mon, 19 Oct 2026
 06:59:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010143156.379864-1-andrey.grodzovsky@crowdstrike.com>
 <20261010143156.379864-8-andrey.grodzovsky@crowdstrike.com> <sashiko-outbox-166685@kernel.org>
In-Reply-To: <sashiko-outbox-166685@kernel.org>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Mon, 19 Oct 2026 09:59:02 -0400
X-Gm-Features: AclHuK8-chbj1rVBMLedg9wJZt3mjYJm9zJvcXutim4nnDp5VmLVfhBvB6zqLxU
Message-ID: <CAOu3gNj7fYONFo2-UqcBVv5Uk2=d4Cw=0fvQvLPCwiDA6zc3Wg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 7/7] selftests/bpf: Convert veristat to BPF_PROG_LOAD_STRATEGY_MANUAL
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: Le87kz5a0JVfZmLE-arFTZ4XqgKf13Lo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1NSBTYWx0ZWRfX6AjoQa5iI0Ea
 lfmYsWSnyoAdw8URUkNHpDYmNKKXYSWQeNK4+86+uFYVr+IC4hBpYeJPwgQIGeStlQfkJ8GCcRq
 Lm9zFRf5CvDJzi8M2oLjb1eu+Y1ZecC4cmhTBl+ed7LRS6zcpoif+8ssNLs+V8mRkL3QiedQ8tt
 bWVKch+wl4ddVm8CQzR4Scz8qi4IlYJUVSXamF1E5ld/QwmNOCRt+W9dQpRM68mBcw/vRvNCfTE
 LE5+cMyLdWzqKBNn1ELhW3+BqRAkDCp9Qki+5hkGkKDNKarvaqj7EqWn5XIVrz0vqsKyUQcR53d
 kP2LE5Ye/79bVnLLBlJX151l6tL+1WUx3GlWmpCoytp+Y0/P7kteJn/Yfo8dkStCAc/UCshKazm
 oPoQc4MWl1SFIrWURl4GrEGYQM9UKdHUomLlu5VK4sov85Cs30kDf/dFoICCjXMfHamtbmHllsb
 HnUQelrP+H1eEPDzuwg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1NSBTYWx0ZWRfX+Mmt1fHa2wI4
 0TtONcXYNFAHMmLbzqDPXO0X9VZNDNCCZHnQnMY1htmCGsnvGxj/OmZUwl/xfu5hfQnw8Pct6XH
 JhA1bdlDHPQkF7lejgl1KWg6VHdH4XdW48Td3h4z8o+PHY8YPP+/
X-Authority-Analysis: v=2.4 cv=ZIVCCn7b c=1 sm=1 tr=0 ts=6ad62234 cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=R_n4Uisa8axJ7jemP0ek:22 a=c92rfblmAAAA:8 a=pl6vuDidAAAA:8 a=VwQbUJbxAAAA:8
 a=BiacRjDT1vw9CRUp734A:9 a=QEXdDO2ut3YA:10 a=nd2WpGr1bMy9NW-iytEl:22
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: Le87kz5a0JVfZmLE-arFTZ4XqgKf13Lo
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11940
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190055

On Sat, Oct 10, 2026 at 11:08=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Medium] bpf: veristat uninitialized memory read of log buffer on early=
 load failure
> - [Low] bpf: veristat skips cleanup and info retrieval when BPF program f=
d is 0
> --
>
> commit 9ac34aec88e7eee9b39c53e8055bc5989345ce5b
> Author: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> Subject: selftests/bpf: Convert veristat to BPF_PROG_LOAD_STRATEGY_MANUAL
>
> This commit updates the veristat utility to verify programs using
> BPF_PROG_LOAD_STRATEGY_MANUAL alongside bpf_program__load() and
> bpf_program__unload(). It replaces the previous use of bpf_program__clone=
(),
> ensuring RODATA maps are properly bound during verification and subsequen=
tly
> dropped upon unload.
>
> > diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/sel=
ftests/bpf/veristat.c
> > index 9cfc9b4b41c12..0cd19b59037f6 100644
> > --- a/tools/testing/selftests/bpf/veristat.c
> > +++ b/tools/testing/selftests/bpf/veristat.c
> [ ... ]
> > @@ -1726,18 +1725,15 @@ static int process_prog(const char *filename, s=
truct bpf_object *obj, struct bpf
> >       if (env.force_reg_invariants)
> >               bpf_program__add_flags(prog, BPF_F_TEST_REG_INVARIANTS);
> >
> > -     opts.log_buf =3D buf;
> > -     opts.log_size =3D buf_sz;
> > -     opts.log_level =3D log_level;
> > +     bpf_program__set_log_buf(prog, buf, buf_sz);
> > +     bpf_program__set_log_level(prog, log_level);
> >
> >       cgroup_err =3D reset_stat_cgroup();
> >       mem_peak_a =3D cgroup_memory_peak();
> > -     fd =3D bpf_program__clone(prog, &opts);
> > -     if (fd < 0) {
> > -             err =3D fd;
> > -             if (env.verbose)
> > -                     fprintf(stderr, "Failed to load program %s %d\n",=
 prog_name, err);
> > -     }
> > +     err =3D bpf_program__load(prog);
>
> [Severity: Medium]
> If bpf_program__load() returns an early error (e.g. from libbpf without
> calling the kernel), could the dynamically allocated buf remain
> uninitialized?
>
> When env.verbose or env.top_src_lines > 0 is set, buf is allocated
> via malloc() but the fallback initialization only null-terminates the
> static array:
>
>         if (env.verbose || env.top_src_lines > 0) {
>                 buf =3D malloc(buf_sz);
>         ...
>         verif_log_buf[0] =3D '\0';
>
> If bpf_program__load() returns early without modifying the buffer,
> parse_verif_log(buf, ...) will read this uninitialized memory. Could
> buf[0] =3D '\0' be set directly on buf before loading?
>

While this is a true observation, it seems to me this exact scenario
would also happen in the `clone` case, so it looks like a pre-existing
issue.

> > +     fd =3D err =3D=3D 0 ? bpf_program__fd(prog) : -1;
>
> [Severity: Low]
> If standard input is closed, can bpf_program__load() assign file descript=
or
> 0 to the loaded program?
>
> If fd 0 is assigned, later checks will explicitly skip handling it:
>
>         if (fd > 0 && bpf_prog_get_info_by_fd(fd, &info, &info_len) =3D=
=3D 0)
>
> This causes the program's JIT statistics to be skipped. Should this check
> test for fd >=3D 0 instead of fd > 0?

Same as above , I thiink the issue was pre-existing.

>
> > +     if (err && env.verbose)
> > +             fprintf(stderr, "Failed to load program %s %d\n", prog_na=
me, err);
> >       mem_peak_b =3D cgroup_memory_peak();
> >       if (!cgroup_err && mem_peak_a >=3D 0 && mem_peak_b >=3D 0)
> >               mem_peak =3D mem_peak_b - mem_peak_a;
> [ ... ]
> > @@ -1774,7 +1770,7 @@ static int process_prog(const char *filename, str=
uct bpf_object *obj, struct bpf
> >       if (verif_log_buf !=3D buf)
> >               free(buf);
> >       if (fd > 0)
> > -             close(fd);
> > +             bpf_program__unload(prog);
>
> [Severity: Low]
> Similar to the issue above, if fd is 0, will this prevent the program fro=
m
> being immediately unloaded and leave it in the kernel until the entire
> BPF object is closed?
>
> Should this check also use if (fd >=3D 0) to ensure cleanup occurs?
>
> >       return 0;
> >  }

To summarize, I agree all the 3 issues definitely need to be addressed
and I am happy to fix it. I just don't know if it should be as a part
of this patch-set or a standalone fix?


Andrey

>
> --
> Sashiko AI review =C2=B7 https://urldefense.com/v3/__https://sashiko.dev/=
*/patchset/20261010143156.379864-1-andrey.grodzovsky@crowdstrike.com?part=
=3D7__;Iw!!BmdzS3_lV9HdKG8!3il3wicS8Eiw2ogONUagDMIrsqcvvmLZ1xXNrquJMEVXEJr8=
5kqsNp4CNFasNUc417QJ6t73GShkLS7-x-efgKPJp1HzLOdaJg$
