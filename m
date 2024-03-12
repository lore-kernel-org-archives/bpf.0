Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12441139580
	for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 20:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710274647; cv=none; b=l0rrFXW9iRCH7Hb1oL1Ut4O7xj8uMePkeOZcAA0gJezBpEdfhth0RJOvrQtIzDThqwgdG6EzoCBJqDCG0S9FB8QFzv4OA4uiS+ie+soduJ8Tcc4GmfcM/Tz4stI3+HFtqv/RHOAVWkXM8vqtN5o5QyXrnFNIG2lRZ7PWLqk1EQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710274647; c=relaxed/simple;
	bh=QfiI841UMd+b4M6uGOAl6Tti6206LQPlspjZ1aGj+vE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IVf5EbSj3C4BogBW6SINPjF5Tw9rTLK6OlJOvAILHVmvTH88o+osHIhdAMOI6YXqFeq7qcjNNFbAOPc3N6VetQaQ4+4bLmGYZzavt+Dhbjix2siMrM/650K2GZTUBwPhHELhzJxeuv5vxXIjhmG2yp+xRStHvMfjyTw8X7avjjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=U7QWMctl; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="U7QWMctl"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so41213666b.0
        for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 13:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710274643; x=1710879443; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vIGv442Bb3GoyJ4GTJ4MmhCFvAXMUZvcBMa8Hexcis0=;
        b=U7QWMctl/G45JotggaKN/dnbq4z7uMEANnSMQSWr8GgMCMq8NX4Vu+jhYssskbwA1V
         wc7293ZskkTB/97luDvU/tXjNdI2uVhGlvN13HVt8VpmCpV+uNewwkhM30iP2C2xn9Qp
         IPJwg3n8bk/FIVjJEeP1IuPK2eI8R122Ann5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710274643; x=1710879443;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vIGv442Bb3GoyJ4GTJ4MmhCFvAXMUZvcBMa8Hexcis0=;
        b=JPlpElhVwLtCu0Ch98Y1aGEhVDhjsfVel26zH3IN6zJ+Pp53zpDqzCVsh/0ebSQ5qR
         e9tnrOh/KPYrB+wEfwOKvXGa5Jt1RognbtE0BYLAOGFJ5uBh+PTyElSt4fKLDIDgFVen
         pBx0/779JF1uScsfQ3mIeS+zWO0u6b3/xgcL5hm/L3Cyds3hjgGBE4hz/bnHLbwmjQx8
         7eCr+hEzm2KDNrGUhBeRCzqyKZryG7Wl1YXGSMq2VHURWSMAdbOrWqjcrMv5xvazmzu9
         7KKXjYoC/nomL/7p6VdBpymV2VAiRwHUbDpRZkCvArcpNR5fZdLCCL9BBh7ioyOu0wWg
         IHAA==
X-Forwarded-Encrypted: i=1; AJvYcCXzMwrxVYkzeQaKC4KYeRfgaJgj4bB8zrVwPUtg9eeAvW9vuS0U5IJWtkNUn+lngxMTBl3XhZjBU3L2UYmKJm8zHLeo
X-Gm-Message-State: AOJu0YycwzJdJz6laqYFXFyyVXYR4D7Gx8b/0h4gE3Tn00GEVdgbntvb
	cWw9n1pyxcrYIz6jyBqkSbCCMZudKr/rwD3JefI2xsp4Illx3oIt42kGHf+tllWJiG2Zy8kD5X0
	ERoZG2A==
X-Google-Smtp-Source: AGHT+IEAooDJu2kAdb1q4t/pBSVB16otJgBrA1Jqzbw+88moRIHRolN80yW/bNdLV14yXUKFUznZQQ==
X-Received: by 2002:a17:907:d383:b0:a46:1cbd:c2c4 with SMTP id vh3-20020a170907d38300b00a461cbdc2c4mr650699ejc.26.1710274643217;
        Tue, 12 Mar 2024 13:17:23 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id le13-20020a170906ae0d00b00a461d26713fsm2859645ejb.103.2024.03.12.13.17.22
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 13:17:22 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so41210666b.0
        for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 13:17:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVrs3RKCLHZ/aAKLSQy1wDkdr6NRBTG4vncM8TLUyI7EEUl4eTkTedfV8yPTlMzuxkFglVq6oAi5P6sj8ZTpfTshYkQ
X-Received: by 2002:a17:906:6c8e:b0:a46:479c:1c1 with SMTP id
 s14-20020a1709066c8e00b00a46479c01c1mr521289ejr.19.1710274642338; Tue, 12 Mar
 2024 13:17:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312042504.1835743-1-kuba@kernel.org>
In-Reply-To: <20240312042504.1835743-1-kuba@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Mar 2024 13:17:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgknyB6yR+X50rBYDyTnpcU4MukJ2iQ5mQQf+Xzm9N9Dw@mail.gmail.com>
Message-ID: <CAHk-=wgknyB6yR+X50rBYDyTnpcU4MukJ2iQ5mQQf+Xzm9N9Dw@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.9
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pabeni@redhat.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Mar 2024 at 21:25, Jakub Kicinski <kuba@kernel.org> wrote:
>
> I get what looks like blk-iocost deadlock when I try to run
> your current tree on real Meta servers :(

Hmm. This "it breaks on real hardware, but works in virtual boxes"
sounds like it might be the DM queue limit issue.

Did the tree you tested with perhaps have commit 8e0ef4128694 (which
came in yesterday through the block merge (merge commit 1ddeeb2a058d
just after 11am Monday), but not the revert (commit bff4b74625fe, six
hours later).

IOW, just how current was that "current"? Your email was sent multiple
hours after the revert happened and was pushed out, but I would not be
surprised if your testing was done with something that was in that
broken window.

So if you merged some *other* tree than one from that six-hour window,
please holler - because there's something else going on and we need to
get the block people on it.

               Linus
