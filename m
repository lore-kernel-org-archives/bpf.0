Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D312353EE3
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 15:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772639529; cv=pass; b=bNwFztuJEKYLkuhhVIW7e3ZCppc1J5NIwHRFwEH7zepHTYSuyTAFzvnhJP2jltC0zgX207R355sFY5xBEY9GFShvyxB1nYZQgmzy33WHcIIj3+js1yR0sg7gizW7WnzLShMrln99WQppNcaZbMUlMmg5rSQh1ll+4F4IEOP95b4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772639529; c=relaxed/simple;
	bh=qWKCUMdT2eOS9e5Yd9IJY2VraltrZvXceyC3PloL9PM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aXbIFGjjnmMDDD+dMZw3jeAFjOpY54tH0w+3pd3QMUNIEd+SkZ1TLrtPZjucztlSfU6Ln5pUBvkQFL68suAk4TB0fB9wjUdhbHTJl+O1v2ajKO7BuI/pVlxd6NsMtJbpOvy+/4E0DT/AjrhmjuzqaO7nsC8RcbMfLHyXoTp2HkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LNo+Dkl6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xa+PG6iY; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LNo+Dkl6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xa+PG6iY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772639527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qWKCUMdT2eOS9e5Yd9IJY2VraltrZvXceyC3PloL9PM=;
	b=LNo+Dkl6OW8vtUKl2g19fFetyEtemcn4pIz2lWvk3tQim8xINjG+3rZ8bIgh93X/P5qHeg
	4wmExEKP2yZxbspknzMjMPFk3+/w8o569FY4r5kuk3lsWKhd8LU3lsrlazvLqdPKLz2bwD
	fdc3xTt6x1SQcynGJyKLXEJQQesAAnM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-3_BpB7kFPES8Vjuu4kHgDw-1; Wed, 04 Mar 2026 10:52:06 -0500
X-MC-Unique: 3_BpB7kFPES8Vjuu4kHgDw-1
X-Mimecast-MFC-AGG-ID: 3_BpB7kFPES8Vjuu4kHgDw_1772639525
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b938cb02038so626283266b.0
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 07:52:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772639525; cv=none;
        d=google.com; s=arc-20240605;
        b=ibhs2q9dF9iv/PWQOTAA0Z5poujPS/J7wUfKsJRyornHUVqCOYLJo48I8eWfX0JU0i
         E0HUe9VnyX+suYEuyxqhYjRyp/hVua9Gfn4Zasq2PTSQrwB0trvVn16QIb9DDEgH+Jnr
         wujjbPNhS2EdqzvP2h6Dlgv7Apcu1g1QIEMXPon4y999RBIRF9sUJmcE5cG4qrWCpc2Q
         E8z2nM9CMgPyy6a/wei1cVe9pHVYjOjZtjcOFaZHyQcxDzrn9ho5jWkB1n9K6EGBhxg3
         kiuPQa9a2Gov4MGLz2bjtjcYbRo95bfEWCqncdq0Bj8M5oKJZ3af9ttXJUjBennSQYYZ
         xsEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qWKCUMdT2eOS9e5Yd9IJY2VraltrZvXceyC3PloL9PM=;
        fh=bDe1jqtuwNh0RG2r63jHYeUiSDhw+nkH8aWaetbRB0M=;
        b=B9/G3hPCjkejsXGLLV4HSnibZwdor2fUTzn/Da+9ZNXsCenA7NaIWHlh35ebdteyQK
         +5E2gM0vAvvKDjglyYBKS6EJdw3wPbyCFd4B7r3KTmQgJhFKEu4npP25g2FPBBzdYrxt
         b4dJyrToWFoDSG2gjdbC2mzKfnUlRO2SMlVkJP474jgO3JBeJHQl/euHn5m1XNIv8ct8
         GEG739MhvdTcfODBNL+iGDxu0q0LeQ7dF8JyVyAIefU+i222KSv7h4Pj0iKQpkzgpx/L
         HGYWVb5JqoWEBR+AKY2DHH8bKsYUHe2jXYNXxduhJW9GY6Mt6p/1oXiwbcB5b3hvN58g
         fw9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772639525; x=1773244325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qWKCUMdT2eOS9e5Yd9IJY2VraltrZvXceyC3PloL9PM=;
        b=Xa+PG6iYdkfW/I6uRSunER8YB7dCDSpxZMvYIaRCfuEvMCnxRziCRilpja/XPWGlDv
         8bs/Sw5cgV1nenSa3SaSIbBdHkfv7nKBREs7nthRMUJW0B72mGD7fQZ9q9OndG3OPLnF
         YcssrbJoee/mz7nRlQar5qNlUIkip+dCskL3TZ3hAPfS4lb1jzb6fGHUnzdW/VOwQz0H
         4xv9YsGWpiDGIJQSrGJ+EZtDqhlCb040gWzYE6bC4rjv3bsjZVvwSARNomY/IrveKK4Y
         zRFTz66h/HLtccQvlsX9TOio1dSg4lkc2quxMvP6NUmtFqRakRPmM5cwzeokXdmYmolg
         2wyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772639525; x=1773244325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qWKCUMdT2eOS9e5Yd9IJY2VraltrZvXceyC3PloL9PM=;
        b=llIRtdjwObBhMqh/w9hsGm5h/kkL0f2UKF9HYX1y+V6wDaFE2Shsb3CBzQbj/4qFbd
         CF/o6JZCbtMM23LRDfGt1v2kfQW+DlofSnNCW84JTv9YfA1hsh13O2lyT4277F9An8RQ
         8Xl3nzbzUdpdPOeTCD3gAoP83iG7RvTXSwibm1XrxuIss+xAH6erFWX+vZB0C5SIsguy
         shJgSGDuW62hVufzChmLVSpUHB1UmUdxdQVpS0zUj6qQRDi5yAI6Gur8tSRJWTKn6TfD
         OCBW/8jxFu3t2HqwLjdFHRHLHJZgVfWIvzcp1v0eDr5Q2lSEB+SHA1R6dn1zQQwGfb0p
         F9fg==
X-Forwarded-Encrypted: i=1; AJvYcCVrbsU5NK9R8xp/hbOGlK+yMBhvmvdqLui6uRDNU9Wm3k19WDZSeVSr6On3gAQfoPBqYqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoCvpLKezEJ4VNOZPwN/mEaVMsw0DtsI/eJrM27GTJ2ak5HMBI
	Plaue97wzag5hQ7yf2IDrbCoqD+16A4a5scqjy7IHzaG9GIgoIwpl/m9hKvDAkAHxdQTFHqNexm
	RmBPSXcR14pbufGoiYSIpkn5vxcnhVMwGgKUOHNdnXRSa4h/fb9jDhGSguyDWa8X8Nm16q4MH13
	k/vqQAqcwoIyq/9SA85FjmyfoG/kFH
X-Gm-Gg: ATEYQzzcIDZWCu2c2VP6Gv+U7VlXn6Wvgu3qpDHflJnvYpOI9AvLftEsPthnvf6bgEF
	bBzdUyxSpGN9R2V4oEhC3amK8nY2AJeedI3ec+IoSws7a/gL2UskYrbxPz/Z4thIH1UK5nCMiHF
	OwGbr4FRRphLsbwn0AW3r8JqVsFNoA+N6MDtnD8u9ylFZ3hsWiRpj6WKDtDz9S4Rb4uZOQ+kYHw
	TzNZA==
X-Received: by 2002:a17:907:2d27:b0:b88:4ff8:1300 with SMTP id a640c23a62f3a-b93d4456f4bmr404789766b.26.1772639525255;
        Wed, 04 Mar 2026 07:52:05 -0800 (PST)
X-Received: by 2002:a17:907:2d27:b0:b88:4ff8:1300 with SMTP id
 a640c23a62f3a-b93d4456f4bmr404787266b.26.1772639524826; Wed, 04 Mar 2026
 07:52:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213115234.430232-1-costa.shul@redhat.com>
 <20260213115234.430232-2-costa.shul@redhat.com> <CAP4=nvQ8xFr2mD4z01e656hfE9btiFRu8xrqHiR0zGkDYsiVSQ@mail.gmail.com>
 <CADDUTFwD6i=JJCSSndFK=XHG5YrL3gnW95EMQEQmOM9HCs4tDA@mail.gmail.com>
In-Reply-To: <CADDUTFwD6i=JJCSSndFK=XHG5YrL3gnW95EMQEQmOM9HCs4tDA@mail.gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 4 Mar 2026 16:51:53 +0100
X-Gm-Features: AaiRm53ZP18AvCpSKzFJWQmpMDrtZxm5xUbL7Z0s2bgHsQVA9E8yqYaLnUciwAw
Message-ID: <CAP4=nvSDX68UuHn9xMXP9E-3W7uMs8G46n=cy-e2bNWCzZ_-MQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] tools/rtla: Consolidate nr_cpus usage across all tools
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	Wander Lairson Costa <wander@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

st 4. 3. 2026 v 16:41 odes=C3=ADlatel Costa Shulyupin <costa.shul@redhat.co=
m> napsal:
>
> On Wed, 4 Mar 2026 at 16:59, Tomas Glozar <tglozar@redhat.com> wrote:
> > This should be updated on top of the unit tests patchset [1] to also
> > include and initialize this global variable in tests, right? Without
> > that, unit tests fail to compile with undefined reference.
> >
> > [1] https://lore.kernel.org/linux-trace-kernel/20260119105857.797498-1-=
costa.shul@redhat.com/
>
> The unit test has not yet been approved. Which patch would you like to
> approve the first?
>

As the unit test patchset was sent first, I picked it for
rtla-for-next and pushed the branch [1]. You can use that to rebase
this patchset with the unit test tweak.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tglozar/linux.git/log/?=
h=3Drtla-for-next

Tomas

