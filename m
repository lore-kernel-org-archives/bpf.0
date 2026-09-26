Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com [74.125.228.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564F07478
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 08:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790412708; cv=pass; b=VC5cNLUiSdUXQLsU78sZHK/9hjFlJrOUJYldmB+uCQjYHA1BSuIGCrEDND3RnJb6t7gIKXmOJ56ll7aOHsvgO8j2jo3c/xSSCZnS/FRFMa9rY2hFZ+Lm92Tb9lMutJxpLST9UeZQFmt4fUTlV30Lf1boe3kYyGq0xvtW1GUkQDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790412708; c=relaxed/simple;
	bh=ClrvzgatbdNIfzHS3+qfNtTXZE11veG9RPAtEnozeHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fej9KuTNTlbVo40BMTppsGp/62N3fLW9OWA7oc4HL8gbsUW8EzeKSeJpBAzrQS7wNc/sBB0A8z/7J8oH/BWC5UP1lCosBoxOyQ5KkbnYjGS+R+01vQT1rdOCI9/i290S+IkuKmD1qAhYWSrNESaF1loWrgfBRwW6V7osohSSpCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzGAPU/x; arc=pass smtp.client-ip=74.125.228.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzGAPU/x"
Received: by mail-pz2-f38.google.com with SMTP id 41be03b00d2f7-cc79c0d2bbbso168801a12.1
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 01:51:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790412707; cv=none;
        d=google.com; s=arc-20260327;
        b=SlYbCrUrxx3l46ymEzQf5fd/naNIKvLmOMDfL1CDOA69ndFlYf66PSFHj/uScVO8ND
         nBp7s6fXbTLPYcvNixMkrsvHgCBtP6o6lognJJK/Y6x8l0M/sJoR0JbdRSGXiEXPqk7x
         X8wCV4FPycqNfwe/N2uy8miOnX0eFve9DGtDzcCXnwjWyAsnyVn8dAwx3IKMyDo+2Aqv
         nwd3WtqVSpLSewOHKMQ3s7gFQ9/G//sXPRIgKJ4kMH03N+JjAvlWjbrnvPOQQKVkqSm2
         PDS2wTk8/9CO3xBFRiJFOQSvjVcrjMKOWsQWuc6XEUFoD0IkvaLW+7bbMjTHTcI3sQIU
         v7BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ClrvzgatbdNIfzHS3+qfNtTXZE11veG9RPAtEnozeHc=;
        fh=AwpKRs5T0hj9zdtWZEOovNGTwSkP7sB9Eceqq5JbWa0=;
        b=entLe3cTUpUUiFby9RT18oai9HoS+uI8A9zrKCBU+BsHizQjxf7bGf1R28EJo64Gp9
         cLEMibyqhXrOspShmNc1TSvlPkf6eUJ4qev9dsEmYPx7CvT9YRaR+Ipi9+PDy6sNAcVj
         jzcvsAeuJs4ML3qbZrBPgdw0Mzf8ALULALr4qnx+ESM1ZbTLTl6wWnR9hCYRPQ/Gj+0W
         uEKm0UhHoq9iem8Jr4rgNhR//S4shUYF0F7kPnFZiTaoAHxZOjkAQ1kua7Kb9WLj8Fti
         Z/a/j8DYnnmgg0Zu3v89P6V8ryg2gGPDaWaq+27Ol2kUZCoPxjlIminPWBGmumHKG/gN
         iAyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790412707; x=1791017507; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ClrvzgatbdNIfzHS3+qfNtTXZE11veG9RPAtEnozeHc=;
        b=bzGAPU/xbn4o/1Cx3fioSegaVqLmckhge6uFvjqK4alXXRGhhSTTBTuChVto6GCLLD
         zENtoYhhGYKgu2gxD2K+tkr71lYCOElyH5DlmP/dCPHZ6d59Wse7PRszpcPuOv7ZlSe1
         +hqgHfxuFwuMnCJ5oc7k04KQa8aNctpiI8PviikBePJ6XPt4Q8195AKPkywCbMQ83TTE
         z/ha+Oco6imK5ckn/IkbWlBFdaM019Xt4eKbeEtz+Kz8Qianyt1pzzyf5Cl2ULe2ILMU
         7INalm1qQRi3i7jRMY2kn6+Ic+mPqxri705XWdLb5YwctrEBBbygx37wskK1XP70Dw4/
         feCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790412707; x=1791017507;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ClrvzgatbdNIfzHS3+qfNtTXZE11veG9RPAtEnozeHc=;
        b=HyFpb4RurlGtBA1Nx1/+JYs49LUNV9amBqSZcJ9i0wJ2YPdUdLL68wavOG8OF2gLtq
         ftg97PqPwiJwEeCgzHjkrKhFjRokuvw7InQprXd4pDGFGPocXpL3h7ak3JUo5Quk45nD
         KDQoT+vUUo9ShJVJrvi4gfiiktTG++HbU/SgvM7vVjEomenRQAW0x1DassYv8hIa6ZYy
         6jxuZwr3a0lTfke/oUX4ug78AknnNAC+fo8IO2SB2EnZCjLir0eUvIAsZIqqBnGFIjjy
         A4zOccNJHLjN8D88i1oNIuNiK/xrgFT5ft3IYMDugFnCcjWuHG7JMFOLdfI5zCXAiSI1
         Ldqw==
X-Gm-Message-State: AFuF++nPq1B+QGuSXffgRAGo8/fxkKU3zU16MYwx1P9pR68y0OW6AMsq
	gRyN7T7XwcrJY7Xd8t4VTqoWEBG0kUG7iQc5NnHQxGE9ZY7C82CmgSnbCHQvu8bXAkUasDLURpB
	rNWrf9BeplUOYeRnnrrQG8y4VUXOMjIE=
X-Gm-Gg: AYBFou3snoMAlDY/gQ2UYXOZALHdTNu3ZdPBd8LGU2c19O3RfZRdnBuBZB8fgUDfKTp
	SBFuiJ+smoAZZ5AxZ9yJ+ocPJywa6UsXReOPBh2whwgkDgy5axvcwTXL2UTq8OYlX7GeuhZPe3s
	N3jJzZHB8783J82dZR/8VR7Viz/dHRE7H4lQdE5OplQRhPZ3XinbZXZIJ5QHyXYDeoit4atvYzB
	KjvCOiyXJQ/xLGyjj0gvcbgDpKF+U+iE376yEChze6MutVuN8sb7AgGXBDk71z7vdYXEjXjrZzZ
	VnmmxzS4IZk5ZeeNzIHFttByekFOtOp2oOfm7/m+H98EmKHy87h2136lTjcJO9ad081pt05jjds
	qbGLC3LJ4DLtDiBAdq5jHkJFf+Srdxqgz1Xvvfy1iOQ==
X-Received: by 2002:a05:6a21:a05:b0:3d0:57c3:65f4 with SMTP id
 adf61e73a8af0-3de26c10399mr4092992637.5.1790412706469; Sat, 26 Sep 2026
 01:51:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260926000243.2830819-1-andrii@kernel.org>
In-Reply-To: <20260926000243.2830819-1-andrii@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 26 Sep 2026 01:51:35 -0700
X-Gm-Features: AclHuK9GIz_mrN3j7fn_-7iwtnVyEvS82t0QkH7_ewyX7BIdMZsOy_9Bxh2icpc
Message-ID: <CAADnVQ+43Xc3B8bufgTvC3qphTFb=Y+113MJtY_gD+HcZjtnAw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] libbpf: Fix static linking of externs
 placed in allocated sections
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 5:04=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:

it was applied. bot is asleep.
