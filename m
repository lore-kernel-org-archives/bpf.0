Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7BC35B654
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 12:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772541991; cv=pass; b=u/Pf0IH5OHmBcAXICszuAMzyaCEP17z59PFvXkbilrejkNrwpgYLO2EMQ23UaU3aaA4WwE9t9AjcJk0MLOiYOcBBtfgyeNkrwoaQad32TxXtiCvwKfh3V/UZWLyiCmtHmKg/BrPC5Yu2YvFC5VXHgo/m6uWLeAPkff4oC/3CGxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772541991; c=relaxed/simple;
	bh=JAD0GsAXzpcGD9pr5IR/zQJEInVPlw0Smf5HeV04xG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nsEKk8KgRNCNzl2O0MzdlmP+Qmlk/XsH+s0hHMDmJxiaQwzeA0EtaLRUT55AtHe4ZJoPqXzVtobMeGnMsd1MsVxNrjDd04pQLzV9xURABXnMYApmFvuxp1LAzXpvuhRUw/a80zlj1vkrlhiG+8q4wuQVw1HqeYcbbYHkGIrC8Ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LImXiL8b; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=e3SZOYz4; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LImXiL8b";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="e3SZOYz4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772541986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j6CLwkPWRkbJiv91VgiORsF4nwrwJm40itZvKlHfTOw=;
	b=LImXiL8b169Vy6OAn0msaluYBzkDCXlTKNPz/GZnQijl+kTG+6chv0vVbe4JqC/OZsTksU
	dhTTvYYtilg30zCmf1oKg3i4mmRfpp1NS7CgWr5l9IViRErdbiEHdT/m14D1pfnDzvR16j
	4mGwaDb2fZf7Hm+RhJId9u8TEDVpq1w=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-mc7bfjVRNh2-YesQ0Yp8QA-1; Tue, 03 Mar 2026 07:46:23 -0500
X-MC-Unique: mc7bfjVRNh2-YesQ0Yp8QA-1
X-Mimecast-MFC-AGG-ID: mc7bfjVRNh2-YesQ0Yp8QA_1772541982
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b8ff07df5e4so492393366b.3
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 04:46:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772541982; cv=none;
        d=google.com; s=arc-20240605;
        b=BqY0OuxK5bF/CsQMcM/2qHOl2P/nWH9JGZPZe/FNcTq2Dsl/BsQEpulGbd4DG3qz7C
         JomvthtMbABy1nYAF4V18SiKXRb7MAJUjH1+lVveRhQ2uzi4U2sahufpFFX1SREZ8nym
         xOXbiwmdm37Q/42h6mv0WXmrWTfwkALowbtkjaYMDNpKWEn4BRwKkKpmUkiwYKwlES/i
         sOBnotXsz743VKN3donBP/9/ExvmNXoYqJCcJ+UFVyj+sZyqZfIEvymQdyBSpN/WmvOn
         06ppTC5c/PGACiN2oQcK7q+ixQ3cNPI5WVEMTCAVTmmKKGrpG8Z15mhir8FEi8NSppLJ
         snxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j6CLwkPWRkbJiv91VgiORsF4nwrwJm40itZvKlHfTOw=;
        fh=7lg4VQs/DOlf9GjV8bEXeoH1yjhcHlOD1v1W7kzsCnE=;
        b=P2LQTYB75b96ERhNj8w/wn6I2/ZnRZ8PqsGFd9J/TyQw5QlvWfMDHNn4FSS1IZI9VQ
         slSQ6+/GCJi+gK1Cdy3rBCD8w5POO2Byzlj9lMQyq0ATcxHAEmX/5MFDDIApQPV5ZhC6
         PHd83NMlVJ80Npf5MWj6m280zTvP5Brz0ZdUuCXIaKtyuTd8Mtx6m6NkAyt4CldOa72z
         jhmlgHJ5bOnX5RfqcPDdAyZHuGcigHbiRgDO+bcZDFlGI88h04F850ksd8qBAmPjYfPl
         JTCY1gN2U54VM6UQDxIswJyB4IWpQHi2/mopat95DbgFTq5Bi0EPkTO0ltKNcmevuhgO
         UTbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772541982; x=1773146782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6CLwkPWRkbJiv91VgiORsF4nwrwJm40itZvKlHfTOw=;
        b=e3SZOYz4MDVpeQBAwvCl2xVQEWXBu/GvXpE96r7x+4pXBAyW/cXQmh+jJvnxtpgPCl
         qmAy3g9/5IBPeKyWY3K0nhWoPXCd4pwoAkxnfAJf2VmYrV+mlhqOH5VLueKc4rO7b5GN
         EoWpDosFf2rsbpWwjKknArDVVuSDfjcXZ1kU6xXn/S+ofQmppIvzHJ+feNJDb1GDzd8s
         tbIgfLlh48ME5/QYEt8ggg/Ot3BzhrxOMvCbV6bly8004RAbNz+PVu2rAcHw/Sur/b2L
         xUOqewHMvYdS7CcaJxW0xxQ9c9/6hekWmgsmJ81QyRnSNhlOdvh92ei80JAusO8Dtg5b
         /U1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772541982; x=1773146782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j6CLwkPWRkbJiv91VgiORsF4nwrwJm40itZvKlHfTOw=;
        b=E9b+qSkOLWodaN2lefO1poPQdr+ocou2xjXLUm8coBOxKQD4v2eCBW+PBqlVbZVQMY
         bpdQ1KH6O49NgmTRd7IDlauzRA7Yj40VgGDbq7v7T1JU+FRe6EWG3du3lvEWxUgdl1mT
         kOsvDJ/X2iDa9OHa0k/r+MHyr35bHH/knYxGZ61tg3ZA9zycnhfDYGXRq47O8AJwo0qk
         d8DJbvJIDeaBxKP8X2caCrBwNvjvmb8i2148OaUL2mgpATX8bJ96rPOuGyqc5Omp8QGx
         57R+9eGfj+iKPY+b7cVux25tQ9zaKYMAOQMKOEWZIL1WTMR3393YDCBbHmSELqDvn4E0
         7anQ==
X-Forwarded-Encrypted: i=1; AJvYcCUa4YGx5dpk04gI7yTNCmWvcwxl5rx7KyGflxVDBEA6qeUSFrHRwGo+dlsh9nFncxFmaA8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Moao91DPqy29+rbmdXpChau1pVwiQXtThdCrfcD1/f0stCzL
	2PbQGddJx5BAb9qsy12PiitDpKbU8LHwAT9fgBs2YD/m0NyCzhhihnM/E+MpYs5912pwZXx0oVc
	nmPl2B4vxhPDHqrt2g0VM4ggBvG6/U4dzjTKjNeAwufPBZH1RnnFxZW3/eVTWKf2hK6EgnE95Cd
	mhmtdSQbWJEBA7mSO05QF+5ndhbjBt
X-Gm-Gg: ATEYQzwsTv3equog9QkZ8y9OMChp97MJusPlvl8sBVMPDIKrhZA08RA1/6dpEUxHeFk
	+GDAfVknNR25St4Ugh6x+Jem+H6XNq/CTT5apzAoaLzDKFgAEx6Vx+8B0lzVbRIxak9ehsvyIR9
	g6xR4CIlA04kJDtM//GwZfK1bdsXRS84NzqHDk5hoNTg0nJcnlwPBV6x1xDmzwdYM5SJ8RoKc/h
	1o7zA==
X-Received: by 2002:a17:906:ca57:b0:b86:e937:d097 with SMTP id a640c23a62f3a-b9376514675mr729184366b.38.1772541982382;
        Tue, 03 Mar 2026 04:46:22 -0800 (PST)
X-Received: by 2002:a17:906:ca57:b0:b86:e937:d097 with SMTP id
 a640c23a62f3a-b9376514675mr729182066b.38.1772541981952; Tue, 03 Mar 2026
 04:46:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115163650.118910-1-wander@redhat.com> <20260115163650.118910-6-wander@redhat.com>
In-Reply-To: <20260115163650.118910-6-wander@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 3 Mar 2026 13:46:10 +0100
X-Gm-Features: AaiRm52GZVPjzh-rd5h81XelxgZ2dXcPJjs53KKG-UzICR-7mah2HbQfJdFe3ZQ
Message-ID: <CAP4=nvTqJhM+0KuDAOooOtgUEad4t-7oOM7pDKxiMzEz=Pb5Pw@mail.gmail.com>
Subject: Re: [PATCH v3 05/18] rtla: Replace magic number with MAX_PATH
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ivan Pravdin <ipravdin.official@gmail.com>, 
	Crystal Wood <crwood@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Daniel Wagner <dwagner@suse.de>, Daniel Bristot de Oliveira <bristot@kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 15. 1. 2026 v 18:26 odes=C3=ADlatel Wander Lairson Costa
<wander@redhat.com> napsal:
> --- a/tools/tracing/rtla/src/osnoise.c
> +++ b/tools/tracing/rtla/src/osnoise.c
> @@ -52,7 +52,7 @@ char *osnoise_get_cpus(struct osnoise_context *context)
>  int osnoise_set_cpus(struct osnoise_context *context, char *cpus)
>  {
>         char *orig_cpus =3D osnoise_get_cpus(context);
> -       char buffer[1024];
> +       char buffer[MAX_PATH];

Shouldn't this rather be strlen(cpus), a new constant, something like
CPU_STRING_MAX, or a value dynamically computed from nr_cpus? The
buffer is used to store "cpus" concatenated with "\n" to be written to
the osnoise/cpus file, it has nothing to do with MAX_PATH.

The contents of osnoise/cpus can be arbitrarily long [1], if you
specify more than 1040 CPUs - which is theoretically possible, as
CONFIG_NR_CPUs on e.g. Fedora 43 is 8192, although rather unlikely -
it will be truncated.

[1] 17f89102fe23 ("tracing/osnoise: Allow arbitrarily long CPU string")

Tomas

