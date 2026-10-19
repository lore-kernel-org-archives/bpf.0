Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A49E4CA79E
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 10:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792404131; cv=pass; b=U042yQ4Z5lCLwMgreDSsjxxT/KowsFe3oiZYJMKYeE1CfEGPD+fUNABGF9mg6Y0B04+YGpkPze3x6cjymAHpHSfWo3pyE4Gprs4wzituR787n5f5drhuxeTV+mKaN/Ot/Ssa3BOcJ5sZoRiyUWJvnIn1hH+dZ18el2T0y7yVcpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792404131; c=relaxed/simple;
	bh=vpWpmb3YDa75S+dGCCi7peYWMhttJoCHOLpxALx7pic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZCw2HbzuQWmfLxp2/YEdQYIrPZ1ldifBMkvjDpEOB+jXRwL2hNBkjsDNxP1L6mXvPpRS+ebU7TUns3pFxAyduTyB8dorVv0cLOMo1BuVjfij0hg/w+tmJ8y8puTDbypztgyfnVy5KB9cL4Tsx1cefQbZodlYMHHxJCiwNzDl4Y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PE8h4Syn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=U2hfNfew; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PE8h4Syn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="U2hfNfew"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792404128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vpWpmb3YDa75S+dGCCi7peYWMhttJoCHOLpxALx7pic=;
	b=PE8h4Syn7fcVff4360KKeGmn9N3z463/JATIHJjViNxj6YmKhKje8QXX/zwu5p72FWCwPl
	19XNdLYoIZj+BhJS4xNJTu1k+0wSqVs3pdOu+q94VbjoJO7S66MiEp3irwd97DZo7Ty/t6
	mJH7FeWbAepp6GiRn7AQnlZej/hhkJI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-qmY_9byvOMabtRnTyYVTXA-1; Mon, 19 Oct 2026 10:02:06 +0000
X-MC-Unique: qmY_9byvOMabtRnTyYVTXA-1
X-Mimecast-MFC-AGG-ID: qmY_9byvOMabtRnTyYVTXA_1792404125
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c210c66672eso227953766b.2
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 03:02:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792404125; cv=none;
        d=google.com; s=arc-20260327;
        b=kCzogvnR4icMl9aYJlT9Lb9+k1jtw+yryheX2zbXmQ8xYMJvdmib5fLb3mOwGi6e9n
         XDUW7h4ZKvzvlS4rmDwJ7fMZdhqkNaUgOe2oMVscNYM97lurYbEM59oih1Hcy4ZqmE9+
         kHkQzWbphxq7wgBVtQy0qw8cG6TlTQ6Me/YBn8eIdR/2UNfE+60MdLKyFPaFPH6reVNB
         jntIVetrQ+x/bc9EjPrItz/qprID+EDRoRDDtAh1+35WUSXnmYYjZ5GHKPLD4swboJ4P
         BoASCqyWADQqEbkOvPG0f36VsIcH76gxi9pm7thT6WMsyQ+VkwooWy9UWwNi1U6nUwSU
         4YoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vpWpmb3YDa75S+dGCCi7peYWMhttJoCHOLpxALx7pic=;
        fh=zxYCsda0OAZY234u7EaV2eo9GrbD8JFjsBlm9LMbNdU=;
        b=DW+ebklvgKox/zCP5kVr0Gy9mzZrMQYisJGwQO2GueudRCIRlKPNyBMVGLQdUoSq2x
         n2Ymp+Zyu4AuEp/qzUe4vj7L65j29mwkv068a/B4qTUMdfkLW8Iaq0u40cHbWzQ79XED
         xjlUhpru50Uw48o28uM2iHUnFsAnR0zD21WLKVpUOXVrteSc15rzrbCl9/C6/B4x2F38
         gY475/5fawIHl3RLm1cFdhUNU3IGI46RgDcbtEawjkDI2kOcYYbHIpr3yojSlLfLAU7D
         H0zZ9pGckxxAHZEaelDbBMNc1rTBI5la6OhVDzoFWljO+mksyzKc3Bam/KFcJHBr2Uv1
         JSVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792404125; x=1793008925; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vpWpmb3YDa75S+dGCCi7peYWMhttJoCHOLpxALx7pic=;
        b=U2hfNfewy1hD8UOmqJUmLOdTyhkIfqYpBwI2KYmpBzMC2tCUzM7WFlfR0glfsjUb2v
         K3iy0790fb2N8k6qlJWHMYi2bIoWVh1jF2G5Pj54lXN9devsmZfHmTZlLdNJlCBAkY0c
         j26wZRlT+ZWhOrR1oGeKtw3cDOpEVBP0CfVPq1gqopLLo18hmNBWmaLvNbVg+hPus6ye
         9pXKqabYTgWrrEEOupUDzrMIgFq9P/P20niiJ0YsWkxIrce/3CVg2tExyVtGk6yAP59D
         mXYRgNjHxUFZPMi+d4WPV96idnixAN6HxT6QJzj+7rOaPTlcKlkBOiCHrJc3z3nHQKxO
         /dXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792404125; x=1793008925;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vpWpmb3YDa75S+dGCCi7peYWMhttJoCHOLpxALx7pic=;
        b=w6IpmjfOMQ6iQu168q1jl161NNeiLeMypT+izGqx+9FfXtGimPFzbqkpA/UyDpZ443
         qb7B74xWlZbwLu0nBBn1szqHuUETmmtERhhlQy1TVxVk12ta1WMUSdCYEmojg3LVYpYF
         8lb0OlzqX2j84lj8lAKCicIGY4P48zJwn79VezQAhbEEr7b06n5MLP6pmFFgmBOUWvGR
         Ie3K7HSTdvtD9inSUX6Ovy1Cs2K3Ce7Hej9QoUrdvOO9Mfx2UrJVPHRpPm+B5mt42Vl7
         3qq1kw+YezZHj9NcohQ5sQm6xhxDhhd2OfHNyyso0BObZHA0/nyVBy3bSyu8bTojVY+Z
         0uBQ==
X-Forwarded-Encrypted: i=1; AKwUvBynhF9Yh1Ahij9cso0mv5L8eib9m0JYbsPSuKILoImCAnclhTFQ6kXdHfwlcH1CHzWEEOE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJd43oFqg9QxSUmBtG/TJC3rkTEVUjXtrLk1GsgRGWkjy/CJCav
	UbiYw4bat/+8jYldTGNPxhLaQnzvdsHqTCKVIhv+6rNTMQGYIZ2pCPiZUxBpQnKbXzfWvUNfB39
	3qNSZ8nROsyP4PqZgRvPGbyPKNtHbLQOTJ8h8xWx9VMHZPVvXZmD+VHWYR0vwu6c8b86yuwcETv
	S+gbFGmsdmnZwchbSrjlJDeEeSc4WsLWw3pa+T
X-Gm-Gg: AYBFou1Bdm4qjQ6ihF3ByjnX8zOgDFnQ++wr+46t0QYDRpdEbE1udqGk7CNQtF28rJ/
	E9FpX2SYzCHbjQNCgde7CZHZQad3U9BcT+x7DhiT4/c1Inz8tp5922/K5CTZz3U/B5yR8foX/2Q
	pM7nNciiL52OlMW4JqHBPUwROomD7XIQhS3v9GbGNL/ZO0j7UY8a4O6z4+8yi2mDws1Xf2E9BMb
	34aU14K6uBjtRQ=
X-Received: by 2002:a17:907:a2cd:b0:c2e:7e0a:572f with SMTP id a640c23a62f3a-c419de3d0f6mr427564266b.21.1792404125347;
        Mon, 19 Oct 2026 03:02:05 -0700 (PDT)
X-Received: by 2002:a17:907:a2cd:b0:c2e:7e0a:572f with SMTP id
 a640c23a62f3a-c419de3d0f6mr427557966b.21.1792404124608; Mon, 19 Oct 2026
 03:02:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001152042.124445-1-gmonaco@redhat.com> <20261001152042.124445-11-gmonaco@redhat.com>
 <DLXSI4BSRE5F.1TLKCBUAGNDFQ@gmail.com> <b1fb01e1c58893795dd4be346f233d39fe653aaa.camel@redhat.com>
 <DM6H7SK4YZ7A.F0MM6C0I77OR@gmail.com> <878q3xtptq.fsf@jogness.linutronix.de>
 <8B3FF026-6159-48CF-8FEA-AF2FACD2E4EB@redhat.com> <87bj8s8ih9.fsf@jogness.linutronix.de>
 <DM78SVMBI2XW.2XHVC67VON48A@gmail.com> <87v770uuyr.fsf@jogness.linutronix.de>
 <DM7I2PYHNKXE.3AYY3N1HATXLW@gmail.com> <87ik2zryzo.fsf@jogness.linutronix.de> <0055967d4571e7c8549dfa476fa6b15b93013701.camel@redhat.com>
In-Reply-To: <0055967d4571e7c8549dfa476fa6b15b93013701.camel@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 19 Oct 2026 12:01:52 +0200
X-Gm-Features: AclHuK-g9NcQuSX2oEVaSkoEXxNQmoV5Ee9U7uVHOzoGFLemx-m8yG7uigcHu_s
Message-ID: <CAP4=nvR2i092924zszA8Qh0UUYnwXfAsa+7KjPe-NpwC+bbLXw@mail.gmail.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: John Ogness <john.ogness@linutronix.de>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
	Wen Yang <wen.yang@linux.dev>, Tobias Schaffner <tobias.schaffner@siemens.com>, 
	Viktor Malik <vmalik@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 11:05=E2=80=AFAM Gabriele Monaco <gmonaco@redhat.co=
m> wrote:
>
> Alright, I'll focus on trace_printk for now. As I said, it's rather trivi=
al to
> add another reactor later.
>

One disadvantage of using bpf_trace_printk() for RV violation
reporting is that the event will be caught by every instance that
enables bpf_trace_printk() and does not explicitly filter rv out.

I can imagine an RV-specific trace event for that, however, it would
require a separate kfunc to generate it, and ideally also distinct
labeling of a BPF program eligible to call that kfunc. The "rv"
userspace tool could then iterate over these labels so the user knows
which violation events can be expected to occur on the system.

Tomas

