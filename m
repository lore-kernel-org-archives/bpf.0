Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.228.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795511314;
	b=xhfj2ROU3YbVEfbGPERfiyiGQqWZ75Rpba2C1FW0+AT14P7MaHpnFcbb3bFqik5IYSlB
	 iMST/9NEotBFnk3kPiUAR47fYcuNCN+fx+rU1hl0zKn1kveiH04dRa2xXWD/cf2flHcR8
	 GDXjE7IGUhUtuNDsDUp3WlA8gcnFhCJbJFK+GoR+M5Dj4NmRtFaadm+M/DAyYTYnTpyQE
	 3ZKdB01pld9TVJyqRJ4ZxbX62EMwu0oPjdthss2XRuTAexjoQd/WgQyETC/b1Adod8B2E
	 S4VpAHxL83ci0v1G+13qHHFLXB6Pf9CHcyxARPj+A4RDr/mJJoDoteCopyJpXmKOuFw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795511314;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type:
	 Content-Transfer-Encoding;
	bh=kSZFSMfdDI+RezxA6ppZj9B1PTPKj8u2v6zHhJ+UZto=;
	b=vsgW/9vQgxuu7/s3C9//WSbYhonFZUcLilCK8gRrQHIUwshC4PDy9wQKMOj32+svbfvk
	 yTJboGAKE1AZuRk40vHWq/A+gEGPFGbgzkfwaxmdCJLhKNQM1f3kELnWRim34R11cDTxL
	 xgnF+bT9KMUyKcdVFrj5wbZ2eDicI0eX8Zd3XtONKP5bQiOKFdkKODWfDAO2/z26y09ty
	 ujLPdcG3yZYs4k0+g6s0SMgQXjGGogtFe6zKpSnyXo9zZIZo1tdl84fFwKp8Vqfy4xuwf
	 BWhsehR2kfuNELIcsrrUX6QYSP33uXVTSuHjXMz+iehFfxU3SSxnLPqm745Esup7TeQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w+LRxGyN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.228.70
Received: from mail-ed2-f6.google.com (mail-ed2-f6.google.com [74.125.228.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9034606A327
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 09:08:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9034606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w+LRxGyN
Received: by mail-ed2-f6.google.com with SMTP id 4fb4d7f45d1cf-6b71d7b8fbaso1499683a12.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 01:08:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795511312; cv=none;
        d=google.com; s=arc-20260327;
        b=qhJo93kfs6zwZGpq/IkUJaOp8T4IBuZ6AKwN3PTXbyfWOx1WqIfcyhs/6F6BJNhXrc
         SegqiJzuU3O+AHVP8UViBL2BENLYdDF3kodvor0cS9DaClHa7WxDzddjG83cU6dOddRb
         CD6KLhz6xf6xgTvD+c+qSWRCN3r1z9r35ocEBLx/aXigJvy2/qJmfJONs/NkRM07dSpS
         RWvt7Lt5li/FNueVpZC67kOdCy0g7c5tiCLm1ipd1sppPFMIZ9xclUZT9SXOyI1G32tT
         Q5IEegn3ox9jVgdMGjESEV0b0YrRMtJXcUUIN0x7cDcK5TiK+7LApx/XOzpUmp5MVT4L
         9buA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=kSZFSMfdDI+RezxA6ppZj9B1PTPKj8u2v6zHhJ+UZto=;
        fh=NPVFJnkplS0XBaxDJfGZcLOa8RPQHO8kfhXKRMGAFb4=;
        b=a77K4cRUe/biQoI18RPz3K5rUOKArRplig9EmtFxVMx1D2F1VJ1IhIxZ8hTTBmF9W+
         yvR4fgAL5JlnlwxJtBCDd4/5n3sMckna6EwFUkJBMFRBc2G/XNvPqGYvSVniVEkgawMG
         p5mO7D4pIG5FV0TTeyvUmebhBFW+CmXRqcPx0SNO5v9iUl9TNRAHhHzoIfX9jiHJ2HU7
         zpN4X5I55HL0iMoRluDihG/lBctnk5cI7uSPsVboxPtzkeZS30zR2OpEXJNB8nsmlbQi
         EgFititFo+zadsCuxRY2h0f2/gX1GT69M3U7/Lrg/SQqQzkaoSBCCs7TYHPXO8urR1Rs
         gJ4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795511312; x=1796116112; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kSZFSMfdDI+RezxA6ppZj9B1PTPKj8u2v6zHhJ+UZto=;
        b=w+LRxGyNdDtQr3S0PZk6aOxn1aDx/pYaqsrgWbDlFWQigst6xo2mJ4jgHU5rk2SdEY
         k91MSS8msGdBbr0SYgObH1l4tg3R4bOd8gNs796O4cj7AnkVJyOql1pTTiaht6cHGhR2
         dGbfJGMWxUcg5Y66/g3ZxoZmpdAliBcTYJWxOVv9c5KaeKFchxOXPhZXoJyRAC2hzEJ7
         i74aMAn5Bu+AjNp15LPpRlf/NMoOO9Qv3WS6y3ReO56D0TNXXOx3jJZ1EnqpWB2sqdHa
         hW20EzU0bUk7/CP6iKrfOIPzAYU2F36ofm0E2q+1c4wd+qUubU1+7fJlgBQRhDvMQeVQ
         x3wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795511312; x=1796116112;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kSZFSMfdDI+RezxA6ppZj9B1PTPKj8u2v6zHhJ+UZto=;
        b=OrGckT0t3/ssCeVpTK9PAguZXjvYJpSHyyxRBi0+5lpuI6/6UzshmQMKNQHNbWQcQU
         OPiHmpIjTrxuXptNvVUAt6GHNVzJa2aNoYLw5lh8M5sRCH6vwUHAiazMPpFQKw39QxD2
         vcqRuaDm96yfA0DIXjv/+oVv6fiBMlb9mD3aY6lkIqb/TpO1qefc+v9TgmMQUTCbfseA
         9oAbLsSjBZ9KBay02sIidDZBRQUPzO83gEkqfLBjP2iKXPnr4k7AAPYLP6VjVIJY4vuD
         lH0qxtKHTkQGLPrNtOA24id73WMyL2Wca0lrC+37bwVxRMjPbC9+3bhf5KuPc5/tHmB2
         Enfg==
X-Gm-Message-State: APuU4Z/9LcPf3NTUs/n4yTMY7MrfnSb1vmjz2Mx4M78ztlniBaiIF8Ri
	NkKRXxOIm0JvTRHt6eiarfZ+B52ZwzmnukvLFXJyiAE3scCkUFeTw6fPc5CrlRRtgZMpvr8BDoS
	prLt/3UBPiLk4QImiPyam1oBbmb7DeJaqL1k6TbXO4SO1
X-Gm-Gg: AZFdTZdXeXeaKtTdCmRbNf2kRtceNFbkGPlSa1hvMOelRs1phYzIuWe6N7tufEeMRMf
	vljCJnVojQ70CMcYOtgVgE0/raSq770q2f+x4AxAeVJ1cHfUESgnA/bJhAxFKJDu7Fqj2NEbego
	Aym4bU6+F6p5A7VjMM4PVE+R8x7juOMgPHjie3TshQ9dk3Kv57VtKpg1h42EQ9xt6EsYqTqdLJ5
	JAZ6bnjDNSWPggfgukIJOw9E/KVR+jpRaGLuaOAsrp1vAZEBBa5fPLVTB/JFjUpQC/B3XsoAfnS
	D/loCdVpnhF88duGmqTnqTaXyVgc05zDjo00K0Obhkp+ZX16WEJb6ktDMnxDcUaScqyRAW8cDEO
	91TRQQVbEslQvd2BPmWpAt9803LJEbWBKVGlzTIUV3wDPfLRAwKYFTNc7aqpc7h2cHIOQvg==
X-Received: by 2002:a05:6402:1e92:b0:6b7:d55:87e4 with SMTP id
 4fb4d7f45d1cf-6ba37e831demr10108841a12.25.1795511311873; Tue, 24 Nov 2026
 01:08:31 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: =?UTF-8?B?5rSb?= <wanghai8081@gmail.com>
Date: Tue, 24 Nov 2026 17:08:20 +0800
X-Gm-Features: Aa3M54qor06CxEIDPeDyxhUB84QURavEVccF57yuXaJQ7qu7hWc7X7AZTM-Md_c
Message-ID: <CAPig4syGNH7_LGZrHyQismhLZ9zanbDAAkwjcWtiFcWfpB6v0g@mail.gmail.com>
Subject: [BUG] libbpf: bpf_program__clone() uses a stale module BTF fd after
 object load
To: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Urein (2581269643@qq.com) and I ran into a problem with
bpf_program__clone() when cloning an fentry program targeting a
kernel module. The clone works after bpf_object__prepare(), but
fails if we call bpf_object__load() first, even though the object
loads successfully.

Environment:
  libbpf: 4f05fb027a08a8a66d03916cf6a68a91e2c720ea
  Kernel: 6.8.0-149-generic, x86_64

We also reproduced this with libbpf v1.8.0.

The BPF program is:

  #define SEC(name) __attribute__((section(name), used))

  char LICENSE[] SEC("license") =3D "GPL";

  SEC("fentry/ip_tables:ipt_do_table")
  int clone_target(void *ctx)
  {
      return 0;
  }

After opening the object, we prepare it and call bpf_program__clone()
on clone_target. This works:

  bpf_object__prepare(): 0
  bpf_program__clone(): 77 (ok)

Calling bpf_object__load() between those two calls gives:

  bpf_object__prepare(): 0
  bpf_object__load(): 0
  bpf_program__clone(): -22 (Invalid argument)

Looking at the code, the initial program load caches the module BTF
fd and type ID in prog->attach_btf_obj_fd and prog->attach_btf_id.
At the end of object loading, bpf_object_cleanup_btf() closes the
module BTF fd, but the cached fd number remains in the program.

The subsequent clone copies those cached values into its load
options. Since attach_btf_id is already set,
libbpf_prepare_prog_load() skips target resolution, leaving the
clone to use the closed fd.

We checked this by opening a fresh BTF fd for ip_tables and passing
it through opts.attach_btf_obj_fd. Cloning after object load then
succeeds. Adding an unrelated MANUAL program to the object also
makes it succeed, because has_manual_progs defers BTF cleanup.

We also tried reusing the closed fd number. After filling the free
fd slots with BTF fds for x_tables, the clone loaded successfully
with the original type ID. On this kernel, that ID refers to
ipt_do_table in ip_tables, but xt_compat_match_to_user in x_tables.

We haven't attached or triggered that clone; this observation is
based on the load result and the corresponding BTF entries.

The clone API documentation requires a prepared object, so we would
expect cloning to work after a successful object load too.

Would keeping the module BTF fds open until object close be a
reasonable fix? Alternatively, cleanup could invalidate the cached
attach information so the next clone resolves the target again.

We're happy to send a fix and a regression test. Please let us know
which approach you'd prefer.

Thanks,
=E6=B4=9B
Urein
