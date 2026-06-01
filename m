Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E148434750D
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 11:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780313602; cv=pass; b=jmPwoB0Yekm0Pr/ezcyds8S4WS0Ndhu6erBsVoBIEQ4dIcsEEGmRJaiZXtnubbh417G3/LlaBq4QdcwYteKHw5sPXWl1hUaeslmh/FkIQs4vSO56r4Zg1QrmvrGrmxGLKhx6IGYi7U1EO00hI/pF+9zLWlQ83UBiT+6chxQX+aI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780313602; c=relaxed/simple;
	bh=uVMhWSI3M7PqFpwkfEATZt8vBsIE3hJ1C0QZF5LG9t0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=dCmogWgQ3LvQ/pmR82lWTWHwWdc2FbikibjFVedUVYOMya6Uu28ZW4wxKjbgBAeXlucEjCHsqNbdFz5/wY3zaWxr3rrAkYxYCrSt0Nxx82hMvZEdo6n7aCmak2DnyDsHhx6U8a+x1/UuElNIMyzjKqmMGUcE+XGAyLCT87qPR0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=NxZq/K5P; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="NxZq/K5P"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c85b2139015so289915a12.2
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 04:33:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780313600; cv=none;
        d=google.com; s=arc-20240605;
        b=VjlD8g+5x60GXNfrkoLlmogqF92WTsnn45lW6XW82viSGxapQ2bVsp7O2g3Yojlx/r
         dec3csmMzSb+RG1BSllWoGxJ0wFcvRT8LFhz4ynQOhWqbcGCPtEE4Ai4B4lpeS+yP0F5
         vPxwzVism68aoWIxS0Car1k+5tZ08J10kJU4LnU0QsHCF86urrLDaAaqL/dVX0WU3PlS
         PjSIlyuhmJv/4xfyPaUa3dKhHjlyNrpCeEIAhGAaKfqMWeFfiUzthRCDYshez5xaahlE
         Hhpa1dH52pj2OI9rL0RPj6xs0s9P8nMlV6KqUlLNIWhtmrKEGKpDzG2a1FprCbH57viO
         axZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=uVMhWSI3M7PqFpwkfEATZt8vBsIE3hJ1C0QZF5LG9t0=;
        fh=JHVvHxZBpyjcZFiYRAb8BLoZzkEwV0lBdO+3H7tssDg=;
        b=DLuUoHz9Oi/X+iVpFWaqZgBIOuCc1sqwSae9cPTozPXSdAy/g6GM8vztB5ZB3oEb8+
         9Y+4X3KLGeb5yVJznOvlHCOJ4A7uN5kUcWUpwqqAylZ7d3GAZAD15FvWCy/pzHcPczfB
         dStrOuDPRZSzmreSUQM4FOaAlZT0w4YkuMDIPr5XSrXf3541rDNO7BN7Fbq+loU2z55x
         /W37PB9Qjphl3HE8C0gG2a0ue+AeYBQlaOE0RB6c3lKQfZXxMGDnFNxWTs/cVWTXMlZZ
         qm7FQtWNHdKvTlmr8k8Lf+OFoN1w3UAptT6z7aWl9SkvzSW94z4VtGepSSqMpkv45pYZ
         fPhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1780313600; x=1780918400; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uVMhWSI3M7PqFpwkfEATZt8vBsIE3hJ1C0QZF5LG9t0=;
        b=NxZq/K5PUE0h0E5mGzSrCcr06uEotsZJnn5qP20NrM5IJBFexugyZDJon0nmo7VDjK
         LAsOk5Kav4Jj2LBD7XkQV9KBDwQ0DJjBWBd2u5tdFg443tQC8c/v4YGU0fSgAeinMXtP
         UILenMZXPIcO414OeOhdT3GDiKYB3rE/cdROQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780313600; x=1780918400;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uVMhWSI3M7PqFpwkfEATZt8vBsIE3hJ1C0QZF5LG9t0=;
        b=OuiRe+sUF4gSTfvjhKgIvUcdECImkB+iEQG/t5EIA5Ckps6Z81ooETESxg5b+TjfdR
         igtF91JscKf9UoIq2elyKddCTOUbR5zQwwbrBlMubgTRr9ZT8agFuD8HjkmoTQXZW69y
         tOCFlnAcUBsjKk9o41dgdO3lltEvjeIfhKooVFxuHvLIpdFApt23S4VC7Dj9pquQ6Gx+
         4NafMYxtib3baxXHzWsaWHuw7WBJFjno5YEWC/3OyK/rt5kxmR3s5GAaBxChAasy2FOR
         yMPUEPmYiJ4bD14od8iicfw1sKmxrQ6Rn/q8mHDuskyi+x8y75U3z6mwG5FQlkcWNJHq
         gJSw==
X-Forwarded-Encrypted: i=1; AFNElJ/+4m7O+6kLhrfj0zMLZi49usZGOvMYMfOctYt8e7XrFePGdjBkMo6NsI0OhBCf0GZXn68=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBf/WRhw9ra4ytXPiUuEHTZzxkqvpAX9+4bLwoR+HPziAchbiC
	2iaspsLz5P2uXHrV4mtIeFnz8rFm84orilcMW2+bWRSKuiZt+ZxzSPswEFkdZtsb9erwGONWXqT
	++UxnxdbmzYC6Lrrs+JkOoRsFq93OjKzMQx46TScE
X-Gm-Gg: Acq92OGVISJ0bJ0bQFZ/0p5WGVc2QHd+lLBJKWGoXrLnU1glfdzsYvJm8wRS4dOvQSy
	aQxyjpX7THWqtYANPs05cD0YL5AE0e0OKKmKwJaHpEhs0T9HbX4qVSjo4aEi45BVkoxXOK1AmcA
	myhBfRVfyBfjEjyHoxg4+UGUWFA8z5PoRFWC7Y5bRan8wBAesVGZr3IUF4BWMqB4pwO70bgE+6m
	1JBroAq7YuLL7irn9mbtwpPzn2a4sL4PY+1JelO4FLp2mUtuM4076sZsGtOF64tv7jWfdTDULUe
	LJJcnw6HVMnx6lLHasgNWNxLqg==
X-Received: by 2002:a05:6a21:7a96:b0:398:b433:87ed with SMTP id
 adf61e73a8af0-3b427f5dee5mr11677802637.44.1780313600132; Mon, 01 Jun 2026
 04:33:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 1 Jun 2026 07:33:09 -0400
X-Gm-Features: AVHnY4I4Oq7kfzkvATZfqv_I4dIxsQYBxFxWE5rf6WImcq-_O15EbAx7JO-P5HE
Message-ID: <CAM0EoMkbu0Y-qhtdQ03Zn93JKOUHd6yZy-DJ2mtYDC6aehsR6g@mail.gmail.com>
Subject: Call for participation: New Age Tooling BoF
To: Linux Kernel Network Developers <netdev@vger.kernel.org>
Cc: netfilter-devel@vger.kernel.org, 
	linux-wireless <linux-wireless@vger.kernel.org>, netfilter@vger.kernel.org, 
	lartc@vger.kernel.org, ovs-dev@openvswitch.org, bpf <bpf@vger.kernel.org>, 
	people <people@netdevconf.info>, PJ Waskiewicz <pjwaskiewicz@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Apologies for the shotgun - I wasnt sure how to best reach out given
the short notice.

The recent AI tool bug onslaught (on the victim side for me) has
highlighted the changing landscape on development tooling.
As an initial skeptic I have to say the quality and accuracy of the AI
analysis makes me feel like i have been in some deep slumber. I am
still very clueless.
And for these selfish reasons, I am helping organize a BoF at
netdevconf 0x1A (week of July 13 in Rome.it) to discuss this new age
of tooling.
This BoF is a catch all for folks engaging AI in security (you will be
in a friendly environment!), building tools, doing code reviews,
generating patches and general automation. The intended focus is
networking, but adjacent areas are also welcome.

Come and discuss your tricks of the trade. The contribution can be in
the form of a talk, tutorial or demo.

cheers,
jamal
