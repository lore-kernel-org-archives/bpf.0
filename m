Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424CB3EFD11
	for <bpf@vger.kernel.org>; Mon,  2 Mar 2026 19:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772479547; cv=none; b=X1YJBOiY1BFF3hPzG9RZ9EcTrmDBFKnZsVyJdcebi7J3sDihdE94BY9OK408HJZ8jOxvEPNeQmQFO8FVTrWoVERL+wemqltCffy5QvAJq+fmtIgu8ibXj5TLziJVHCRXe+eBc8mKxUGZhXZqVifVmpEmuAs2eDN9DNSZ1N55oGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772479547; c=relaxed/simple;
	bh=J+AUgqG2xB7p0sKYPoHbxW6oqiPof/phY6bFlgGx9HQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kUwvjN85OgubRjiBUXOGw4WQ7UdedDwRscMwkT8lzvGMHCrQu+oVhPi7FBnr4Fb1d4tb6gYHv+S2iDwUpsDUNoJtgCQycIwKndPMtijD9g6SdpgBiC+R37ubfGIGn80qCp/BfYjzHG2wpw4Xpu9oGzy52IfpbH1TYBsOI6Nb2Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Jou00DTl; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Jou00DTl"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-65bf2f59d64so6074610a12.1
        for <bpf@vger.kernel.org>; Mon, 02 Mar 2026 11:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772479541; x=1773084341; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=J+AUgqG2xB7p0sKYPoHbxW6oqiPof/phY6bFlgGx9HQ=;
        b=Jou00DTlV1wLf0s4P+EguDlXj6dUcr87XTAPjrfaUCeBzWAgXqJHc9UtRukwpMub7V
         bq/+HKiC5rv5z5eN94CNObbEu4DYJ+yqQo5E6dzrJPRGZ1Hs/M6VOjONnpR7rhwY31cR
         iP5UajxX1GmZpxa4QVpQ6XSc2gOWUKb970yTJh2pvC3ZujvEee0PSXrHN+V4yufaHsKi
         ysJiyJqnHeuO8g8wT9TJ2L/7wJiVsaCCO8MxuimJMCACqJs9faMHF71IAyO8AYUlaMZH
         ZRfo7zBh6LYOFnOed0gDypMeUTUgOnLYvq2QGgLOyWlgXE4Euk1sace4slt6VZ1O3EaL
         mUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772479541; x=1773084341;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J+AUgqG2xB7p0sKYPoHbxW6oqiPof/phY6bFlgGx9HQ=;
        b=Kz87vcL9IlSDfaFDyt/MSOlmiFomxqddYB83H6Y1Fr/98fcV9TfJZDq+3kjqcjKfxY
         JIizbLauLKA10WclKJVrUQW9pzMY77BnZqoFEQM+kfYhAPAlKHQaim9C6oTfcCTg/VWC
         sEr7z9vLl9ijpPm77tekM0mKakonjCwOIxpt9e/m/9mVzl0nH7QvDcN1xKbK8a3cehGw
         cPjTU80AYFWa7e6LxKKxbA82ByHTDLZTBGvtM0j1wPlI7kes6ieESk2xVXeWcMmgSoaq
         X33mY7T1cYfQ1eIt4vY56aikv1Kvn1nfcBH8N3gkactT669bI8aiba0wfBEteeGf7NmD
         rWbA==
X-Forwarded-Encrypted: i=1; AJvYcCXB99wJBFGEN/2KIJbG45c7H5/Pwev5j6GjWfjSMeCiUPQYxhjhJNoNpAFV54ZWJnHGEbk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj9RgXvJb1zRfCjmGdEna+sjkSXHVfh0EWk8vnc2rvs/Io/Y/+
	0CK5MWB9DpjOHXMpM+ev0dYsEZwWMgDUHqeM0UDOkF+DCRD7JPV3dq663dHrArhfEgQ=
X-Gm-Gg: ATEYQzwqHc2N4tFdqSE6TFrsoTNovZv1vQ+2UubSigr2vlIDO+i/XFMhJZ3feeYhvhX
	VCyBeQxnuGOW53aJfEQ6jZOScY1y+ifIUr824RAmao9jYC1pSpL5DgUcRIM5h9ZSeskzT0Wl64m
	X5vYvH3jFmnFlbo5wh7Q6VYwKGgE4OTbs7XQ/7eJVE0ORNi05wdsIMLKsjCyXMaoKPAyNnLF6Hz
	eTY9FDwmxuaLjk5rtxqbWeAf0BysnJoPiOTPFqBUAoXLspm0Z6pQO9QLRdccvQNDZYssRJ7veIE
	sEekLa+adurjEqWbf7xTS71yerDYe0dfenUFdWJ1sn+zDiTsnFvUkum4zAKm8IJN9jcUg2YIBxQ
	VC1v0bENOl3kZzAFY/RAn8DqXA7dU+jRVHQ+Vj8qwIUe1WtuK8LC8P/drfuDeucYAZORsGv13gC
	1oHxCKm98yvHxtrMwQpwqThgVa13w=
X-Received: by 2002:a17:907:7b8e:b0:b8d:bf4d:7464 with SMTP id a640c23a62f3a-b937650c1e7mr881773166b.39.1772479541241;
        Mon, 02 Mar 2026 11:25:41 -0800 (PST)
Received: from cloudflare.com ([104.28.193.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935ab137a1sm505344566b.2.2026.03.02.11.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 11:25:40 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,  bpf
 <bpf@vger.kernel.org>,  DL Linux Open Source Team
 <linux-open-source@crowdstrike.com>,  Alexei Starovoitov <ast@kernel.org>,
  Daniel Borkmann <daniel@iogearbox.net>,  Andrii Nakryiko
 <andrii@kernel.org>,  Jiri Olsa <jolsa@kernel.org>,  Steven Rostedt
 <rostedt@goodmis.org>,  linux-trace-kernel
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [External] Re: [RFC PATCH bpf-next v3 0/3] Optimize
 kprobe.session attachment for exact function names
In-Reply-To: <CAOu3gNhBcW-JQ_VQ00GnLd8iB6xu7Ew80Bs4VHoXOct5g-wr4g@mail.gmail.com>
	(Andrey Grodzovsky's message of "Fri, 27 Feb 2026 16:15:07 -0500")
References: <20260227204052.725813-1-andrey.grodzovsky@crowdstrike.com>
	<CAADnVQLrhkCkpE6UZbkPaNTFMYRoa_ZtyknhVM7FMmsH7Lvj5A@mail.gmail.com>
	<CAOu3gNhBcW-JQ_VQ00GnLd8iB6xu7Ew80Bs4VHoXOct5g-wr4g@mail.gmail.com>
Date: Mon, 02 Mar 2026 20:25:39 +0100
Message-ID: <87fr6idoek.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Feb 27, 2026 at 04:15 PM -05, Andrey Grodzovsky wrote:
> Hey Alexei, just to be clear, do you mean drop the entire RFC letter or,
> Drop the RFC prefix from the letter so the CI pipeline can be properly
> triggered ?

The prefix, not the cover letter.

Although I think swapping the word order might also work ("PATCH RFC").
I've seen CI run for my patch set when it was titled like that.

Kind reminder to not top-post :-)
