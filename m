Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C19275AEB
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 22:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785191699; cv=pass; b=I3gEb+a79Wp7gAXaFGBzlL7bL0qebayk3wR0yQf81blrUNnrWYjOx6rSPK0vnt/zvJjSb3EERKsm3gu4HRO78iLABIiJfy3Xo3BvdHAdJIdEdvOjzjmmHc8E1VuAuA6bP7w223XmaAt+xeOVg9wgftQa3zgIENIsQjb06rQny3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785191699; c=relaxed/simple;
	bh=7TEtiOjQggZMEkErBJEVdUElI840RrHz3d6Cwx3+Ugw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hG07hmX5PXXTsbD0sZEAU2x0EXYre6A8IY1t7xDovBKlwteKium4cePyeBj4JVOhhiL515KEd1Zi/4cDf0XnFYg6r6f7OF1GWDp+wW81gnJA6fMnrkm4gNJIoLgNb1ffRZfwE3LNCRJWHyK/0HuACEqj0ZpamUHKaaItNdvirck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hP90/doz; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hP90/doz"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84a2dcede83so4318062b3a.3
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 15:34:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785191697; cv=none;
        d=google.com; s=arc-20260327;
        b=doWb6LMKh6zZ9aLLfIyCcbivWf7xv5HTwusiPtgIPRaM9hOqVVJBrPZrIOTFFuzGim
         EOlfQbMpcxYrGZV9hir3TWnTyxy8Y/qpjoYt8S+qY99mSaO9yHuGQwdgmRUyEuIO8CKQ
         btoZi1pv6u0d34B6oZ6tZBxer8a/r9fiy9aH8syd0wrR4W5U818J8F+g0Vf1fOoKcMDs
         +WYkH5sVdIPm68mFfcChTFyKwhnqoD/zExw88f5mH1NFCIXSCXGL6Je+L+sHoMYG5bcy
         iyvXkH1ZQ62iwsklR+rsLa8nqT621fNQ+UnCY3MeP36xQyzAyaiwUIWumPVfgagui1U6
         zZSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ckKdQKUGKaG+4QmZlg5923goGW5J8z++c88IMXwUfJw=;
        fh=3f51OjAlLt8QvW5qIbZS+s2CbDCf1x95/gkGZtD0vXs=;
        b=T1MTzheznYdQ9FUSo0Yh1IMATFrEFlbB1ZwzvrSBh5jcjyEl14ttBc8gFDrDYNswIH
         F1++S8gfDyb9U8837wM1oASn5h2c6m5I+8M5oBdgLSvDLDIXLsdHLOBvKQJdFp6+oJUr
         7V/TJ5/nDuZ2K1D03SGoGKtWcv4amjKrG0Y9D/0Ee3uxjSEqGvg1FZNXsGj94GyImRRm
         xuLppvYIzi9RVU6RoppjPOXujxuM73ZM93c8BDFup6ynIZ6AOHPTT4dyD0T4d8BTjkGZ
         yqB+cnig2Q6MnqOyooBClfNE3NujHnKKw4wVxrHXOgAyoihnfi9wlakQa7yLvM20dT6i
         T9QQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785191697; x=1785796497; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ckKdQKUGKaG+4QmZlg5923goGW5J8z++c88IMXwUfJw=;
        b=hP90/doz5L+6aRqvUPPKf4M8pYtZbbP70JdiTW1+JN/YHd8Ip5VBhw9krfLC0Y6eFH
         MLX2U2qarKACe27iLEuUgXl0ezLzfvJaaearPoRf7wTLZcAkbeKKGy+y6+nEBfYg5m0+
         GtBcujw+fbNXJzjdRk9K9l1PF/7qeSo0RpkpWJcdnTxJfR2mB5SOGsLEhNuQT2YusUai
         /iUImcgrPTG6JoPD6qP4Ct8BX7a1oA0Gn99MfoosgUvZp9cc6JNHzs2kAEZ4mr2ghEvW
         y2fiFbMz+yNth0DqrsbqzXVugGwM+xsvAGrQm1HqOgMRFyWl6LOvmGBJ6xuerDNZFZa2
         e4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785191697; x=1785796497;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ckKdQKUGKaG+4QmZlg5923goGW5J8z++c88IMXwUfJw=;
        b=ZDhixxcJUcvQ2RSQfwgj//NnDO4xXTbXf0AKeDRhtgd0+myGdKuyP1uMKRXXK73db5
         fY3CvXrSK0wXGDvLfoIT+UfwLE4AiO3k9Sr4Dd2XPGOvb2YlWRqyMMk37AFIeYekQzV0
         lJauI9fpfOAtSwEzWdvrks/3OPrQwLDrtxv3JcM3W2WsP9cNRoVDda+Trc/TzMUlcUO4
         POcqJLy6c+qHho23a/tmscgBUmaQTXEw+yzKVa5SYFUta2QYj+o9Pl49BY3ase8HIQDQ
         9bS5/88Iakviro7/8y84WNrFIm9pSXCgJMJp2M0EGiDS+jNkqvgkKxi5DjE56OwJgT/4
         qYYw==
X-Forwarded-Encrypted: i=1; AHgh+Rp7tHssAY6sUFuQ1wlkkVu3+Gr/uQstPx45eTdlAwbMqMhOTMz+TLjorur/LOde4GQk2QA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI7jJoYOP7dW/HVCPCcklAFchjnoMWV4GGp959xRAEzXjBpEPq
	Yfj/etuic9yaHygQKxanfZ0wIlgWjU68v152vV9ciggReFQcHVe07CZzMAs9vvRgU0bM2jFZY88
	kGP1VstWqszehbN9Ly5O9swGmSrQA8M8=
X-Gm-Gg: AR+sD10hUC2i9GEQzL8dzDejzBJoniEUgkw+CKUd5Vp7BwlM7SP+FNWGapM/3A+0dNt
	eUaHvcU/+FaEiuGdTGPYnncB+9K/ajbKjmwwDawNslPo1mTQM78O0QiDyory3pwoVmWBqvHGAQU
	PIfpIBJRa9bU/X4sPS1rTzZonfQrklW6zzPmf0KkUt4IWOiqp0FciuHBcUefCHJAZAo05Xr5bbR
	oFihOnHXMio3ed7QjqLMxlmAjLOHutPZg51bF27qTX/mcbB8wp4zqJF+EBi0pDp3sPzaqafTpcg
	DhbngbvU3I7/HXi9FYFgLlzym6Ade1zkZXZS0lsL1RoSdizNfcATDq/Bf6Xz57xXFil0
X-Received: by 2002:a05:6a00:399d:b0:84e:7ec:aa42 with SMTP id
 d2e1a72fcca58-84e594330d6mr8645260b3a.10.1785191697579; Mon, 27 Jul 2026
 15:34:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718134450.575758-1-tushar.vyavahare@intel.com>
In-Reply-To: <20260718134450.575758-1-tushar.vyavahare@intel.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 27 Jul 2026 15:34:42 -0700
X-Gm-Features: AUfX_mzH-8hI-auF3xbbXN6CBjkT2xhvmKQLEnB2zwkeFu8lJ5TB-EqTuuf6keY
Message-ID: <CAEf4BzYRKO-h=7vhzVnV7Du3fVycZhDdAduUHMta9TxNXXY1+g@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests/xsk: decouple xskxceiver and xdp apps
 from test_progs objects
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, stfomichev@gmail.com, kernelxing@tencent.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, 
	daniel@iogearbox.net, tirthendu.sarkar@intel.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 18, 2026 at 6:46=E2=80=AFAM Tushar Vyavahare
<tushar.vyavahare@intel.com> wrote:
>
> Build xskxceiver, xdp_hw_metadata, and xdp_features from explicit source
> lists instead of reusing helper objects produced by test_progs rules.
>
> Reusing shared objects such as network_helpers.o and xsk.o can pull in
> test_progs-only dependency chains and trigger unrelated libarena builds
> when invoking a single target.
>
> Keep these standalone binaries self-contained so each target builds only
> its own required sources and BPF skeleton dependencies.
>
> Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
> ---
>  tools/testing/selftests/bpf/Makefile | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index b642ee489ea6..a6f0ed10ccb4 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -934,17 +934,27 @@ $(OUTPUT)/test_verifier: test_verifier.c verifier/t=
ests.h $(BPFOBJ) | $(OUTPUT)
>         $(call msg,BINARY,,$@)
>         $(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
>
> -# Include find_bit.c to compile xskxceiver.
> -EXTRA_SRC :=3D $(TOOLSDIR)/lib/find_bit.c prog_tests/test_xsk.c prog_tes=
ts/test_xsk.h
> -$(OUTPUT)/xskxceiver: $(EXTRA_SRC) xskxceiver.c xskxceiver.h $(OUTPUT)/n=
etwork_helpers.o $(OUTPUT)/xsk.o $(OUTPUT)/xsk_xdp_progs.skel.h $(BPFOBJ) |=
 $(OUTPUT)
> +# Keep xskxceiver independent from test_progs object dependencies.
> +XSKXCEIVER_SRC :=3D xskxceiver.c xsk.c network_helpers.c \
> +                 $(TOOLSDIR)/lib/find_bit.c prog_tests/test_xsk.c
> +$(OUTPUT)/xskxceiver: $(XSKXCEIVER_SRC) xskxceiver.h xsk.h network_helpe=
rs.h \
> +                          prog_tests/test_xsk.h test_progs.h bpf_util.h =
\
> +                          $(OUTPUT)/xsk_xdp_progs.skel.h $(BPFOBJ) | $(O=
UTPUT)
>         $(call msg,BINARY,,$@)
>         $(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
>
> -$(OUTPUT)/xdp_hw_metadata: xdp_hw_metadata.c $(OUTPUT)/network_helpers.o=
 $(OUTPUT)/xsk.o $(OUTPUT)/xdp_hw_metadata.skel.h | $(OUTPUT)
> +XDP_HW_METADATA_SRC :=3D xdp_hw_metadata.c xsk.c network_helpers.c \
> +                              $(TOOLSDIR)/lib/find_bit.c
> +$(OUTPUT)/xdp_hw_metadata: $(XDP_HW_METADATA_SRC) xdp_metadata.h \
> +                          xsk.h network_helpers.h test_progs.h bpf_util.=
h \
> +                          $(OUTPUT)/xdp_hw_metadata.skel.h $(BPFOBJ) | $=
(OUTPUT)
>         $(call msg,BINARY,,$@)
>         $(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
>
> -$(OUTPUT)/xdp_features: xdp_features.c $(OUTPUT)/network_helpers.o $(OUT=
PUT)/xdp_features.skel.h | $(OUTPUT)
> +XDP_FEATURES_SRC :=3D xdp_features.c network_helpers.c

I'm missing the point of these xxx_SRC variables, given you then go
and list .h files explicitly... Just have an inline list of all the
dependencies, maybe?

pw-bot: cr


> +$(OUTPUT)/xdp_features: $(XDP_FEATURES_SRC) xdp_features.h network_helpe=
rs.h \
> +                          test_progs.h bpf_util.h $(OUTPUT)/xdp_features=
.skel.h \
> +                          $(BPFOBJ) | $(OUTPUT)
>         $(call msg,BINARY,,$@)
>         $(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
>
> --
> 2.43.0
>
>
