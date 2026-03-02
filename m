Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20707364927
	for <bpf@vger.kernel.org>; Mon,  2 Mar 2026 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772462023; cv=pass; b=aOKPCqoNgoplf+0OLhKpDJGfZlcNfooVsej14osPtGJLXI5YKWQSi/40h4PlBK9GKUqR5R1/E45xhs1nlWAR8ktLXic/6qOcstXxjANJI5UvB1Uhc0LPQomcTEBum7Cr9gl8YhJAy4oTgL4x2vzCNYnu7t3/GyBu+RO3bzTCtz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772462023; c=relaxed/simple;
	bh=uwQmw4zAN79NwhQtiVPfDrwYfeImPdYyqA7w/pehgRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f4Ui59hG6EAej7YdgOupbWq9FGiHM7WpAmNre9cb1ARwghBlwoIXm7CpoUfAgqwy6F3eV/+Y+M/4E+BjhcPq98K0kIDHp3t0Y3Vp+IcW+PWk077WEjRZ5gGSUqNq/69ylySfKhIsrNfy5I385Lo8tsRWDgK3HxUqfunGiCTbQNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FV1WcqLs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LCBaOh6X; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FV1WcqLs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LCBaOh6X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772462021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=01Fk4coTpUC/LFABzMoFS9WOF7gLMZJKwiH8t0NLiFQ=;
	b=FV1WcqLsQy2qrYE6kqRFoKHYoyykxzGMsqHx3E85LdnoQjTTvxyYlXgZmJ+lmnaSzB4qFS
	I0udjX5wEEAnoH1xxs/+h86pOKcEuwyk9gB4wY1GNpbXbRV9VP/6L4SZY2gSrMp1oL0AKa
	4xT1Tblg3mT6WTaw4pQILdwZK4xMoJM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-k-WcCYl1Mr2uExTITK_Zdw-1; Mon, 02 Mar 2026 09:33:39 -0500
X-MC-Unique: k-WcCYl1Mr2uExTITK_Zdw-1
X-Mimecast-MFC-AGG-ID: k-WcCYl1Mr2uExTITK_Zdw_1772462019
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b8f9734e619so345995066b.3
        for <bpf@vger.kernel.org>; Mon, 02 Mar 2026 06:33:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772462019; cv=none;
        d=google.com; s=arc-20240605;
        b=O45RHdpOWc8849/jen5f32EjbaIJVe4/JuqkKri8uQwakLRaoh4IIglV0a95XIxGWR
         Dtk3ogLfINUlsI0bkM6NqpohH9B7zn84LmQXCGmERP+rxmV2u3RGARImeOakCkmwwW2j
         O6h7I4owg/7oQcx5sfrjP9LuoTjq1X+f5sXQmRAxU4fl2fIywFQ5LelgJG7v/HPARuDz
         p+9aYBPFeQ+mUc62V6nLkkRKM1gWZOA5zbHiSk+pyv13a9OeRzYTKMgkdnz9QzPyCw9l
         3FGFQbuTzoVjuAHPGkUCZfaB8U4ot6bH+g7DAofBSURTNiTqyohOp+Y04ttTnX9TZSkw
         McJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=01Fk4coTpUC/LFABzMoFS9WOF7gLMZJKwiH8t0NLiFQ=;
        fh=r9IIPuRgCKbzIRd4ijdISalq2/zs4u8/NcE5niZXjd0=;
        b=HGvwn5RJM5EXSgepu5/TNJowK4ZTyEHbvDXi8A+fY9yVIZxL1GEBQUTSgXMVkKTa7t
         KiL319keTuV635e5rKsZVIhSvkQY9/E9102zCCZmWERRu3swEC8SD0tO9XgVXyL34y4H
         EUvOza8e8/hqgradbO5EhHIYg6S5lAtTsm9Kh3rT4LVIMTOI+ixKbMwxmAyTkXsIs4OG
         1obbaU5s6lVo9XLVDZLn+26shUiek2SpLx0+S1eRebg/zm1u4OQsBQ21n5Je0hZgd3F9
         IKty1nAEYYBfzqiHU/HJ0J7clwaMw+NMxkX5DF4U1GU8pB/zq1t42sthaPOJjrmuqpKB
         FKNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772462019; x=1773066819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01Fk4coTpUC/LFABzMoFS9WOF7gLMZJKwiH8t0NLiFQ=;
        b=LCBaOh6XyO6f4ybG3nJNxEK+bEACJFjjHQkvmvh50RbYbk86BDieto3+wsfUNKpndf
         QWlN5emU+OOfTmfHoBTj/ZxDPss5QrMWtszYxlPRqPoasH2U31NVZFO7XSUd4dD9OTAD
         1CcnJxtOReYmLYd0GztnD9POuzSHm5rB1WVKPXuZ0vjwDUVs/GKlRT72Nj7hHkCqkt8U
         dQPNLdPdticuTv4aSWcrzjj3mHXKXyZ5OnXbqkQLRb06hbXEh/0nKxgBLWfrt6rZh7eb
         +mCAvvUi28swkmpf1Aqv+N9lTmLT6P2PAFCcakzqBkwVYU6bzxtHeq8RhAd5Zp/YcONm
         2fVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772462019; x=1773066819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=01Fk4coTpUC/LFABzMoFS9WOF7gLMZJKwiH8t0NLiFQ=;
        b=qU58dSmACTGP68JRD7hMWyTDNm8rLyo1SNacUzP6dao5yvLgdEiz2sE0WJE8K6eNiv
         AdoaRZyZHKXlcBpvyegK5oYVdZbiAgwkR+pT9m71nQ/ue/0yGRJNqYj43FaDbnJ3DZK+
         mhJdIJqV+LdGhjf91fDAaL8xXlgYAWvzdQa3zaxUs+CwJ2964dz2BvYD4GilWhmNhJkE
         Dkp208C8r8QosFJl3uAPPwbKGt5rRZkaTbEt8fVMWL3o1O/J1/YDg3Y7z5lEeQBZmMLZ
         0Ld19KX1Z09FCcJX27vULV2HUbhsC9BN7rOkRhdAcInBTWluPKgHxw1FUFZeCNAX6Ple
         fNvw==
X-Forwarded-Encrypted: i=1; AJvYcCVsmiAizFLpY1ZwzLfBzMiTjlyXk1/ILRRCnngQjx5CGes7M9pjbHH3POLa6rcPncXkfCE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3jruK+rnMF1W3vvd66TtUqXOeDOmzDCuvXFEOsq08iXe6jcl0
	XCxwigeISaL0Hp8u8hWElIfx5EZSuJaolcXgGeyXSwrDTiuaA7rRTRqEDxpiJ44g6kqThNUddsV
	O6+YEsbAlY+mGn3Ts9t+TaS2xJKJSSPbtsXu9zuggezYSKVutdMkad0ISNhjxo0nQR979dwzYDt
	MiV9ZAr3Vl2iZuxdHe1WKild4tgINW
X-Gm-Gg: ATEYQzwAPFcSB1uHJh0wCsXimoA9Nt55uKJkZF024Ff0NgqLjJPD4QnToh/MvmeIARP
	ajunyY89uFbgKBgE3lfT9Igim50mZqOEvqp+XcBD6G2LXJYNZt/V57TCGpPyuyhIt26nsiigOZp
	eZkjo8aLzfSTyCgzIi9p5wjZVOPZOrSrab99gyG59EKe8WpwAQ+NvTAHRKjVG7bwdmeUMrJjo7a
	qLmdsckJ/EbnFUX/dQ07A1Keee3HRWPRmFy
X-Received: by 2002:a17:907:6d03:b0:b8f:d13:dec8 with SMTP id a640c23a62f3a-b93763b6e8amr729134566b.22.1772462018596;
        Mon, 02 Mar 2026 06:33:38 -0800 (PST)
X-Received: by 2002:a17:907:6d03:b0:b8f:d13:dec8 with SMTP id
 a640c23a62f3a-b93763b6e8amr729132666b.22.1772462018092; Mon, 02 Mar 2026
 06:33:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115163650.118910-1-wander@redhat.com> <20260115163650.118910-8-wander@redhat.com>
In-Reply-To: <20260115163650.118910-8-wander@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 2 Mar 2026 15:33:27 +0100
X-Gm-Features: AaiRm514QxdLOrOwfkkiBNdRkFgDYfMrhEEk-id40dZva7oHe48oQU0sFLt1uLs
Message-ID: <CAP4=nvR1YMQerrJUfKG6a1WaR_ajhOda=Ee5Jit-U=mB6Y9uWA@mail.gmail.com>
Subject: Re: [PATCH v3 07/18] rtla: Add strscpy() and replace strncpy() calls
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Haiyong Sun <sunhaiyong@loongson.cn>, Daniel Wagner <dwagner@suse.de>, 
	Daniel Bristot de Oliveira <bristot@kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 15. 1. 2026 v 18:26 odes=C3=ADlatel Wander Lairson Costa
<wander@redhat.com> napsal:
>
> Introduce a userspace strscpy() implementation that matches the Linux
> kernel's strscpy() semantics. The function is built on top of glibc's
> strlcpy() and provides guaranteed NUL-termination along with proper
> truncation detection through its return value.
>
> The previous strncpy() calls had potential issues: strncpy() does not
> guarantee NUL-termination when the source string length equals or
> exceeds the destination buffer size. This required defensive patterns
> like pre-zeroing buffers or manually setting the last byte to NUL.
> The new strscpy() function always NUL-terminates the destination buffer
> unless the size is zero, and returns -E2BIG on truncation, making error
> handling cleaner and more consistent with kernel code.
>
> Note that unlike the kernel's strscpy(), this implementation uses
> strlcpy() internally, which reads the entire source string to determine
> its length. The kernel avoids this to prevent potential DoS attacks from
> extremely long untrusted strings. This is harmless for a userspace CLI
> tool like rtla where input sources are bounded and trusted.
>

strlcpy() was only added in glibc 2.38 [1]. It is thus not available
on systems with older glibc, like RHEL 9. Using it for strscpy()
implementation causes RTLA to fail to build on those systems.

[1] https://www.gnu.org/software/gnulib/manual/html_node/strlcpy.html

> Replace all strncpy() calls in rtla with strscpy(), using sizeof() for
> buffer sizes instead of magic constants to ensure the sizes stay in
> sync with the actual buffer declarations. Also remove a now-redundant
> memset() call that was previously needed to work around strncpy()
> behavior.
>
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> ---
>  tools/tracing/rtla/src/timerlat_aa.c |  6 ++---
>  tools/tracing/rtla/src/utils.c       | 34 ++++++++++++++++++++++++++--
>  tools/tracing/rtla/src/utils.h       |  1 +
>  3 files changed, 36 insertions(+), 5 deletions(-)
>

Tomas

