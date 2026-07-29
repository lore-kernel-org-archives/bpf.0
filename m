Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1F03264CB
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 17:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785345379; cv=pass; b=eA4+kgUotjVp2pssxwp4hfhEcfkGQBTkP1xSGC6LpJNRu0wvWB9o0mzoUf/lwaaD6xylZePcrLnQyo7gjoQYF2orETi3KOI37yybQweaic7FQ6qG0oAcncWtwBETin3GhkOLOEVCw+v7dKq0wUlj4hV7NKNDzYcrBXbzTowtjRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785345379; c=relaxed/simple;
	bh=CxgVNu8OIzKW/N6Y+uKIInjNOw5NxAfNeZlPCXslq1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ku4tuQtQ8DoN9BbPZWQ5hvErEfUtthmzpxZ7n6hMm35zAegCUKilp0hP2AtaIXeRWWtRWQVNxojMne/cPwjBhWYdip68jFlEjSBnvdFXIO1mV7bJa9ej/Ndv1kiIHuHhYRG5PeO5PtBnSFBLl+EBsgwk3jquRy/9IaiQDp3v1+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=e4GRIUdY; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=gkVcSTk8; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="e4GRIUdY";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="gkVcSTk8"
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TGElrf1890483
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 17:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=fb8tlbgkpHVbx7GRYrC8ZiHMMxx20Ma1OyZcf/SyMEA=; b=e4GR
	IUdYEC0D4NyHMgg2dA+/CR0Y3qyp1HDioC86H+HL+4cMmqBxfbqEHVQXQUvmynp5
	bxjSB1GMxKiQZj49wxcHaf2jk6xUtn3pmn7f6LAyEOAZprMR/mW2pJRtHOun0Krp
	l9mDmnaoa4EmWUyxg+416Hy1+mt1bIrCzCFdCBCemy8D0dGwm7SpWc0fGXGcke7x
	8UiH4zcuInfrnsTb20q7aGO6LvLnQgEF5w/gvxdi480Ov28XKEJjgnvKLe5gZKRU
	PKMXglDnEkVjj8XK36ueFo+6Fyiy+z2KrxcRQsTkT38mk8nrde2RZTUBox0mRLei
	l3qgcvnTp5v2lgl9MQ==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4fq308v6pq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 17:16:13 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7f582244e9eso24396137b3.3
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 10:16:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785345372; cv=none;
        d=google.com; s=arc-20260327;
        b=jIRSfuhJje8q7BtgHYeAxzLfkftpUNQPyKV0/Wiebod9K6POk6H6MJmGxviq8KCCVF
         dC2ZtMvDsHMbCp1+8e6AUK5o+GI7mpXdtJvaEcox1Z5Av3TnnTH22oHHQVlcQJ3RxT7l
         Sj3o0d38el9mqkvjt6WmCnIFLs6DB8eIYztvE9/EhRs14YqAIoJyWGlL1lDO/JaL3Tya
         hMzy0vCd4nOwIvJ3AHKaOP/az97LwCVI4ztrEF2W0vNBwx4lsFNXnuC2+yppmW2P/N3F
         PJCY4pD0jfssS64FmfYCwuVPaKhCmk05YWov9Ok0vJrJ14N3T7+rbx+0qy89f+zH3Gls
         EI5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fb8tlbgkpHVbx7GRYrC8ZiHMMxx20Ma1OyZcf/SyMEA=;
        fh=TY+OUWrckbRi11JZVpHbKuECxv7kW49I0D3L9JeatXQ=;
        b=oZCIWFOFqc7X4fXWtaGXOqdML2Kx7Ghbtk1kgVtGs5xNZUrYUHJIUBZ81fVjMuNnIc
         a3Gay83b2CIgoOW9nPIcejEvS/605QjSRjDwzGISAIolPGoWIUrrL/H1xWkh/EhrtlQ0
         9wPW6LALcg4x6H4+xLenA85PndUP/2SlzJ6VY5L6pZxkd1olE2OQ1qxbSXQ1+1eybiH7
         8bQH+OJvZG45JcI+fx3yhv3UIAIad/gsFU1Mtd7zk37JPXLM+jOyuvi1Idowe0Mringb
         FQ7jWKyGZStwicilA1OIvPrGHPeAGV6UBVfYmknsm26xyq56FvlANkFawuT9P1ZTf+HW
         CLAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1785345372; x=1785950172; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fb8tlbgkpHVbx7GRYrC8ZiHMMxx20Ma1OyZcf/SyMEA=;
        b=gkVcSTk8/9qeOJBSPPYPuy0/Uju9l1knImQXn/ZdAgB6umoiHynoNGSnBNYrro9pLT
         kdahEAP+MQHH5pIYjEuCKE/zbxIuQCxo/27rLdVqsyphJBcFSYNuwcE/rsh5GJunn1Pa
         jL57loQNJ6kmupKMfwQIHIRr+aMq4oJQ0JM0mdp7BbKdmwhyCsnEnOLM4D3QRCRE579r
         iq5Pg86F1NkF7G5Iw0qdIu4gxe5i7+8VOqd5VQaz90hYa+pnrVLKcoQV1Ix809GI5iCb
         eWJXITcjnHkfozd0w5wbiCZZosjI1DAYX7VJq61MvjjH0Nnln5Kv1jfI7zJrf1L6YCqV
         PVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785345372; x=1785950172;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fb8tlbgkpHVbx7GRYrC8ZiHMMxx20Ma1OyZcf/SyMEA=;
        b=QLn780kdqygi3FX1XNW5X2JdOsYYuJ8eH8dPU6x99pETltwolhjWc4tax3W/yiBoeC
         fpnQXGY8JtJUHDcEvFo2cRam7bRfFHKFLHZih9yWVg+U4W/HiLJNoIJJ8LTpFDkxjxuv
         RbnBKa8WJPZ+PUtp8LSCi1hoRupn7RVFMqOVjZ+UHG4FbpZlnC3Z7Q6mSoE/StgMuF1s
         OvMth4xoQHsNePSfrnuUB5fc/24wUlYL0888sP26K0fdW/UvAXPmKnfRe419BYxNpujv
         /yQlf/oX9kHIsgUpJjBCsrj1PjgsHxcOv5I4DRmDeqgJ7mPkoCIl0qsZDKj9NypyMntq
         FOZQ==
X-Gm-Message-State: AOJu0Yw6t81mbFJvU+rapRPav4ekjvNpZHFKIgsMlPS9R8NfatZ+9X9E
	jatQ9Vu7vxJhHGtPW5tSCv7wLT8PV6kQ1dH0RYbdrpTHkyarJ7qy/d7Sfqw9pChJCm2i15/3l0M
	jevmNREHs1gsNZyptmVGvMWtY3joAbqjpR54QJcQixW+9nJppW+n8gEizUy1DqxH/j4LEdFBXG+
	gV8xkvUZKvPObJpVpZKvALIbCerW4D
X-Gm-Gg: AR+sD12GQik2RsNrDfUty6/I0TMk0dN7bnw8KYNa9foEwgZ5Mxuyh5EyeVsibALPwLz
	mMSgkO+UaM6/6nGu5qtCp1dZtFQ+lxphf5bMvJ22Mm4KrBt97ALjDoYx97RbCz6nX9EOGXBJHU+
	BrG2JC6+v2Mg7ubCJjFlTIZnQJxGmt5vin5HFH1Ed/ix4aHa+4bFz0h21a
X-Received: by 2002:a05:690c:4b0b:b0:7db:ccda:a409 with SMTP id 00721157ae682-81f991858eemr37532577b3.9.1785345372491;
        Wed, 29 Jul 2026 10:16:12 -0700 (PDT)
X-Received: by 2002:a05:690c:4b0b:b0:7db:ccda:a409 with SMTP id
 00721157ae682-81f991858eemr37532107b3.9.1785345371866; Wed, 29 Jul 2026
 10:16:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729005959.3853865-1-andrey.grodzovsky@crowdstrike.com>
 <20260729005959.3853865-4-andrey.grodzovsky@crowdstrike.com> <amn-vbX6AitcIcC0@krava>
In-Reply-To: <amn-vbX6AitcIcC0@krava>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Wed, 29 Jul 2026 13:16:01 -0400
X-Gm-Features: AUfX_mzHJi3wnVv2DObG6kIdUJfhyQomfor8B8-bBUF9HAk2TMES92n1JyZbzHI
Message-ID: <CAOu3gNiThogqw_RzEOujeEt3dMqz513ZJdjCDp3nFr3GxvVumA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 3/3] selftests/bpf: add ftrace_permanent test
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, rostedt@goodmis.org,
        naveen@kernel.org, davem@davemloft.net, mhiramat@kernel.org,
        stable@vger.kernel.org, linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEzNCBTYWx0ZWRfXx9tUxklHhbC0
 c/OC6cMhAicvM3W8GW1og821jcoq7xQkHzmH7cOm3ygd8u6QIKfrJ7JtwKoksuNAMbQohhrK426
 dxO9sKrcVn0MDWI/ooB/vCTnmh27rcCKV2887kdZRgn6uOmPXEXq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEzNCBTYWx0ZWRfX6CZA+j6iNV4c
 2H8GxIyq41gzfE+6h3MnLAM+troYD1iB+KLIk2sXzpKgVmyG0Ym3fAWuB0tY+ubLV2TeG5ig8Rx
 kuBzxgXmrmG6pWKHC4IEY4HDWaWXxwbaSImVLRqhPQ9Riw3cZ73FTpubzmZkBz7Nrk/pmRGRCHZ
 gT7oQnDjgJdhH+XrjqrCjKpxEDyBtPtxNBsgZKbMLbIzJmdKGIgYdvriHussQFvTt0U0t2TSIDP
 /ei/Nzt+/uEAAowB2qXIZDPGU6RveZAH4cC1c5B8Fc+g0CAqYf/TgpZh+syPZQKBQmaqX976C+H
 xlNYVE7YznTgT5v8wvn44TAJ6JTkgdewaCyt/PPyJ/4q0qK821IhYmOrSHjeGVE2GRlC8p4jztu
 0RIkPuGOwcQI+K/2NR0GO9G55p4wxVnOu+d/UWuQ5mUEc1KqpHHmSHOpIuwYexSCVCOHX0XIOTT
 MtBR6QNPHo/mD3XdxJA==
X-Proofpoint-GUID: NUq06qkKKu8A2xfA6fsZ4nKWQwvsTBTq
X-Authority-Analysis: v=2.4 cv=fOAJG5ae c=1 sm=1 tr=0 ts=6a6a355d cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=b3B37AjAgz0HnGB3MuNd:22 a=pGLkceISAAAA:8 a=pl6vuDidAAAA:8
 a=JqPfYqdnCgMSl0vctSsA:9 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-ORIG-GUID: NUq06qkKKu8A2xfA6fsZ4nKWQwvsTBTq
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11859
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290134

On Wed, Jul 29, 2026 at 9:23=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Tue, Jul 28, 2026 at 08:59:59PM -0400, Andrey Grodzovsky wrote:
> > Cover the FTRACE_OPS_FL_PERMANENT fix on BPF trampolines and
> > ftrace-based kprobes/kretprobes: attach a fentry, fexit, kprobe, and
> > kretprobe program in turn and confirm kernel.ftrace_enabled=3D0 is
> > refused with EBUSY while attached, then succeeds once detached. Also
> > confirm a new fentry/kprobe attach is itself refused while
> > ftrace_enabled=3D0 is already in effect.
> >
> > kprobe.multi/kretprobe.multi/kprobe.session are intentionally not
> > covered, matching the production change's scope.
> >
> > Skip the kprobe/kretprobe subtests when CONFIG_KPROBES_ON_FTRACE is
> > off (e.g. arm64), read back via skel->kconfig->CONFIG_KPROBES_ON_FTRACE
> > (same __kconfig idiom as progs/test_fill_link_info.c).
> >
> > Assisted-by: Claude:claude-sonnet-5
> > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> > ---
>
> hi,
> I have some links active already after boot which makes test to fail:
>
>   [root@qemu-1 bpf]# echo 0 > /proc/sys/kernel/ftrace_enabled
>   bash: echo: write error: Device or resource busy
>
>   [root@qemu-1 bpf]# ./test_progs -t ftrace_permanent -v
>   bpf_testmod.ko is already unloaded.
>   Loading bpf_testmod.ko...
>   Successfully loaded bpf_testmod.ko.
>   test_ftrace_permanent:PASS:skel_open_and_load 0 nsec
>   check_blocks_disable:PASS:attach_fentry 0 nsec
>   check_blocks_disable:PASS:disable_refused 0 nsec
>   check_blocks_disable:PASS:read_back 0 nsec
>   check_blocks_disable:PASS:still_enabled 0 nsec
>   check_blocks_disable:FAIL:disable_after_detach unexpected error: -16 (e=
rrno 16)
>   check_blocks_disable:PASS:reenable 0 nsec
>   #145/1   ftrace_permanent/fentry_blocks_disable:FAIL
>   check_blocks_disable:PASS:attach_fexit 0 nsec
>   check_blocks_disable:PASS:disable_refused 0 nsec
>   check_blocks_disable:PASS:read_back 0 nsec
>   check_blocks_disable:PASS:still_enabled 0 nsec
>   check_blocks_disable:FAIL:disable_after_detach unexpected error: -16 (e=
rrno 16)
>   check_blocks_disable:PASS:reenable 0 nsec
>   #145/2   ftrace_permanent/fexit_blocks_disable:FAIL
>   check_blocks_disable:PASS:attach_kprobe 0 nsec
>   check_blocks_disable:PASS:disable_refused 0 nsec
>   check_blocks_disable:PASS:read_back 0 nsec
>   check_blocks_disable:PASS:still_enabled 0 nsec
>   check_blocks_disable:FAIL:disable_after_detach unexpected error: -16 (e=
rrno 16)
>   check_blocks_disable:PASS:reenable 0 nsec
>   #145/3   ftrace_permanent/kprobe_blocks_disable:FAIL
>   check_blocks_disable:PASS:attach_kretprobe 0 nsec
>   check_blocks_disable:PASS:disable_refused 0 nsec
>   check_blocks_disable:PASS:read_back 0 nsec
>   check_blocks_disable:PASS:still_enabled 0 nsec
>   check_blocks_disable:FAIL:disable_after_detach unexpected error: -16 (e=
rrno 16)
>   check_blocks_disable:PASS:reenable 0 nsec
>   #145/4   ftrace_permanent/kretprobe_blocks_disable:FAIL
>   check_attach_while_disabled_refused:FAIL:disable unexpected error: -16 =
(errno 16)
>   #145/5   ftrace_permanent/fentry_attach_while_disabled_refused:FAIL
>   check_attach_while_disabled_refused:FAIL:disable unexpected error: -16 =
(errno 16)
>   #145/6   ftrace_permanent/kprobe_attach_while_disabled_refused:FAIL
>   #145     ftrace_permanent:FAIL
>   Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED
>   Successfully unloaded bpf_testmod.ko.
>
> jirka
>
>

Thank you, Jiri. I will address this once the decision on whether to
proceed with this
route or, just make ftrace_enabled obsolete, is made.

Andrey
