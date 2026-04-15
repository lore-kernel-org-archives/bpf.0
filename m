Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4664828DB54
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 04:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776227905; cv=none; b=FToDXsk0f5rozNMN/hkzSg6TWA6Oeu89nRXkpQwJW80AtbWA6Fuitj23eR080kmbYEb+xmSJPuFdSl6+NvbP00tTeAwnIM6I+H1DQEQqiGQFNCAAt3UuF9nODoFZMr+wDz7ySJKxwtUwgvEKa5qfAgSgbDd0F1NNyqUwXM/svSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776227905; c=relaxed/simple;
	bh=gawKAoYtnHZXzr6s+4DnoMrR7qEOOYk0q2XRSUBkUbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=THT9eyc6zVXZXeSJuH+Qoqb6HkFX9qCsdBaN+nFD10HLPXTeQ+Wp3bJg4TMxorCwFbCBx+UKBOOXrdT1jP9fhQoOBS6u/Bs2P/PQe3JiukuTaHGJgAi+PuR0md6rl6dm/jimLD55Je3K9qSgEH1HJbPN8xXUT+3F5+lYwworfdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=W6yiVJcA; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="W6yiVJcA"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6718f315fcfso5061129a12.2
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 21:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1776227901; x=1776832701; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JvJVUs5FbiymwXI4Gxb4sdA9nDlgilD4zHX6vi3SJxo=;
        b=W6yiVJcACsQz+Lt90q72BwB8f/vWNEz/x+PxG5hlNqYek6bNkiVR48NZRMStmjr4Rq
         ipKQDQBq4yrMnjX0mHkE004fsJubZSK8QLAvJBz1rnPdIoANiqx3ICiv6IAMIJ+vACzA
         JxVoHg3F02jb9u7UYu7hg49H5EBoUbLIP8rbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776227901; x=1776832701;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JvJVUs5FbiymwXI4Gxb4sdA9nDlgilD4zHX6vi3SJxo=;
        b=eVbyLrV6nEiy3yDWYC57Cc4GPL8lOilllihrpOFWnbFEexZ+LqEcUs9x2c6oy6Czro
         ZeZTfBtjwyC087HhTApYjg88tmOC1KAvp6Jxjem58IasVvkcmEY4aFh30lTJLF4hKjxh
         wNfAwoFoqXEURywtMM4V/CJwDhmn+BX7+Z7L3GOmb8qBB3wuD9jRqG0Gurt9AR0YXorJ
         dNLkvlWQgh0mGvllRLtXV+GVsR2WtGRjAxY09CsUv9psDO1g6WNz0lLSuLgpZQKCcrPX
         uNsw1/c25F477bcJXug0gMYIsl6DaKPh8JKV6OQEJTCK/MTreZLQ448Vv3b0XIHQ7++W
         bDUQ==
X-Forwarded-Encrypted: i=1; AFNElJ+S6WMog8VZFTyz3g8c1CArVUk8ueCs19rfkV0Q7oxhlS3QdMuTPtWEcHbi4Mwpwbiz22o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBd013nHqhesnd4h/7ZgeWuRlaKgu43LbxfN19Stqvjj7e3pIj
	IsDLLQhn9v+WdfpdS3TQm9asXoTZINvKFfwZ1h9qNyJ/saHuCc7UrwLsVUtJ0WJ5lSs7C+wY+jd
	IOQzglRM=
X-Gm-Gg: AeBDiesV7WhE401+R8oo/3Gtjm15lUd1WJvhJcjHOTqcrujKIg/FRUEUF54I5kkAQVl
	maeDXvdTt2E8VZtwaWnwS+LrJxuZ9RZvIln4A8sZY9HBvMeV5g55XTYbfznH118do1J86imR0M9
	BIk8i5iefsLHRtO+AhIkk8pa2Tx+HsxofCDnhdGrWYUdSGFSepPE4GEgxd494Kn8GBO81PUVv2J
	ACPjo5Kn7N9hWySUJcEV+/gNhrIZWWJajwPLUZq72+BFND2syusqvkUpHh8ClxADdhgl+bR16n8
	aLvP3I2IdLk4FDwFmWjJt4gPn5MOjcs03FYpbwuRPQdmR5m81zQgN45sH8eUEd6MrMKVf21UsEY
	QERNmVg3Mt6JjHJRlNrkIQUJa+5Vup00v404cAs13zbuE9SU7dPNjZrNUKKxedqS4AmvTlYeX90
	wAeHplWfkEd3tsWl7bR7pTaCmTVPR6ba5aSsmJExTnddsJY4cl64zBiXDeBeU57tPB+oi1n5se
X-Received: by 2002:a17:907:80a:b0:ba0:fb42:c254 with SMTP id a640c23a62f3a-ba0fb42cc9amr104588766b.33.1776227901414;
        Tue, 14 Apr 2026 21:38:21 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba17341a9c7sm15793466b.11.2026.04.14.21.38.20
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 21:38:20 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6714f678bdaso5187115a12.3
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 21:38:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9UodWWPhP/FghxnygyRo0vEw84G9ZGrHAMBw/j8EtwcndXC6Q6QvSpgUBmcYVTn5dJcF4=@vger.kernel.org
X-Received: by 2002:a05:6402:548e:b0:66e:b9ad:9669 with SMTP id
 4fb4d7f45d1cf-6707a480710mr9200540a12.21.1776227900298; Tue, 14 Apr 2026
 21:38:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177601563477.7932.4081917600853246368.tglx@xen13>
 <177601564263.7932.2238613098642404049.tglx@xen13> <ad8OGZmCVRc1C-Ck@MacBook-Pro-49.local>
In-Reply-To: <ad8OGZmCVRc1C-Ck@MacBook-Pro-49.local>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 14 Apr 2026 21:38:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj56cA+_m8YL-5HuHeSDsA_pvuH8Lu=K4JG82iw=G6bAA@mail.gmail.com>
X-Gm-Features: AQROBzCLmR5hbB7f7EqreVke3NrcW0op3wHaGVAZ1zU-vtjHDLqhlCd4SODJ_bo
Message-ID: <CAHk-=wj56cA+_m8YL-5HuHeSDsA_pvuH8Lu=K4JG82iw=G6bAA@mail.gmail.com>
Subject: Re: [GIT pull] timers/core for v7.1-rc1
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Apr 2026 at 21:10, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Looks like it breaks the boot for me.

I can confirm.

Trying to narrow it down now.

           Linus
