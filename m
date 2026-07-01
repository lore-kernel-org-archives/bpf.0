Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FC939F188
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 18:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782932010; cv=pass; b=kYXN76dIx5P3BFKkCM8O6NRJYOuGzwRivNaPK652sn9MGeJFlrGgjmbn9O2ruKEWT4pYjaorFNxmLicTBRP+J6g3SZ604ZYpCL9Yt8kLZb+qOTs9GoPE1ZSZSQS0VviWFb0orE8/or5ud+rEpJhDZzVgxJJg7usHUkJ0qwrOen4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782932010; c=relaxed/simple;
	bh=H/aIKbCL+2IFonNeWBah0r+NuQqayuH9uK7OeGzGDhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cUSQm1nJjoqI1Li75gVUn6dQDrYnYdtnuiSb3eDiK8cMEsMU4CmHwSuIaD6Tn8glItuEhMkZFGnwjoI0FLXcyqAAst+FgZnVmCHyY+sGjaS302kVEn7jUoSzGMTuhUY/ziMUl1hgh22T9I02JMz2pmtaH1zGLwskbJNFMNzlVk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C+FhZm/s; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C+FhZm/s"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493b8d92a4eso57625e9.1
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 11:53:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782932008; cv=none;
        d=google.com; s=arc-20260327;
        b=eKATeR5gvFiQgtqDvowQiiuJi23tI4Ba928sCvgUbJiuiMPcCF43rlwp1LAQ33Q2hy
         O1l2aBCTUTBHCc+KlkDnWxjwE1SlCN6F58NMSacrRZRQ+5FKkq5YzFfi1a16PDwyUbz9
         8uT1yMkvVBB1NP8fMH57zW0POfRqd+3hfy7YsVLOcFswFQUJ8jeAGqesZt3XXtXc7V9g
         dJvVpGWlvPjcz+0gPX4DRUh4Rx3/qp2ePW5ZgF0FKiFbVIcN2SSrzcGOVyo9jDxGzswv
         QYNGf9XX66wVbGnuSvTTWDcQFTpyRahw6RiYo+uuYTtVai4MthyXkszMvWvV4xu8BZeV
         QbdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H/aIKbCL+2IFonNeWBah0r+NuQqayuH9uK7OeGzGDhE=;
        fh=3xm7psQ7pKkrWbnNkN0Y30xWjWk+sDP9rr+wHLnstsU=;
        b=To8VjlrptANcpYf1wPzRpzlHS1UvzHS+yxR/BQSLFxy4LuYfT7hgI8g4isSRg9XKb+
         iLi7v4MNMnIwekG81bRArR0ckz34//hU/1Xk9t1wVhtuL4tYakabG7YMUiXb54WelZLI
         fvrDxVyZ57DaB/AwcjSDbxGaoZsSmTjOHXDAMX9of04CAGN5QjhldbWLWWflhp/8rGba
         lNKTdPseVYy3a4/IcIAloFpOygQsbBB/RdEVdSdhmlWJ/A4AHCgAo6BflC5ypfoxYplc
         Prpfss9Z5eHBUMWLzvnWBHBQAqJV1vwd8a8rlTPV+WJqc+AoDmCgHyr4EdZrd9rNNXI7
         r+9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782932008; x=1783536808; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H/aIKbCL+2IFonNeWBah0r+NuQqayuH9uK7OeGzGDhE=;
        b=C+FhZm/sDu3GUp4bC5TqcMGKjddW8eSQJplmgr3gWh/oA6HT2H3Sbzbd1PdnWx/Ldz
         7kFy9oQtdmlZgXSMz3XbxUv1AlYPe6ApGHQzeV3OMSku2GiY+hLjS0le5Xn2abg0ir4K
         EkURVa95OgERswqcs+CtdezlzPyD3P5DgFopT40L34ASks2HuajkrlhjzPsgQf6eltqg
         mDwHyYFbE57qrhYh0ba6Lo6OZTkMqQBvDFml/Zutls/h5rh064CzabJ2jkx3ndjM7VVi
         QhSNO8rHRx4NMA3YnYQGtIKJu7G9c70QUziBeDuoOxdNu7KAHMgG0gyr9m2Raocbu0m7
         1zBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782932008; x=1783536808;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H/aIKbCL+2IFonNeWBah0r+NuQqayuH9uK7OeGzGDhE=;
        b=eG58vQ4vmJB/Xx6KugmInp+Q3sHb22vjYLoXX0Oferp2Zg5MwloDWBLCVxAW5lBzSO
         2CJCUBtCClL8s6Bx8A9T/nENbB7Kc3WmGowkaMs62Grtywa+cUlm3aYseasIewd4uk47
         fZEAVKzVA77OHUaDi4xJMTMQcVVQ8HKvXDnT2n4fh5rx5/YbVhdQaCorBbQaZo5DsNBU
         5jTxGy/WRN0qaZE4mkSyf5ucUHBQsXjv94uK55rxSLIl/EU04pktzYkwDnOYn9KXNu0s
         p0dpQyLt7spX5y3IgIo5Wja85wsTi1GHmDyXarx1lsPwXn9zXE3oQB4fERUDdT2zznea
         BP+Q==
X-Forwarded-Encrypted: i=1; AFNElJ/xt9mhmEd+YZK/sZW9DiBRQlx+iDxsbOdorZw6KmQeLb1GGkQNJAkBAvp+Db9LC/UTMK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsAwI312v8LAx2qEglut+s1XC6T8m53i4i1IqKJKflbHwoWEti
	0oBP5leA55+59GH58XYRj9zf0uT5NqlVb95TlePczbN+Ga6Uu9g8+9+BvRdL9LVuPXhhFJYYipF
	O1KkiQuZLr6wh0fMcuYRIAmismRlCZ63rp+Tx1CVW
X-Gm-Gg: AfdE7cncbNI4xUaVR3rRefKNoCKlL6+DQvJkYMHiU3qm0y3RjXVczTCzMPGiba4tLPh
	UlofCtQ+SfEIQUeHj8HSAx0HaOWOPj1XGpxLjVaAWjIPC1jS6nVqEnNz+8ZjfA+3+6ITMFWT+F4
	7QNruxwtT8yBM2ACcXBMJW4D28Ta23faaWc/1krPT30Cnb3ztmY5Z1sHNp5mWprlsKSYfvySf1s
	/nLGOj6zlI6ZaybszZc9hM4dxv4YZ2xOoQimTkPxUOL23JLW1A8VUUlIuPmkQlmbvjpHLHljXw1
	EXHZq59Xj+9T6BBtYqj7x0eCUWwJUg==
X-Received: by 2002:a05:600c:4c23:b0:493:b169:784d with SMTP id
 5b1f17b1804b1-493c0bca5fdmr869295e9.8.1782932007620; Wed, 01 Jul 2026
 11:53:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625181557.1086105-1-tjmercier@google.com> <20260626180941.45158025@kernel.org>
In-Reply-To: <20260626180941.45158025@kernel.org>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 1 Jul 2026 11:53:15 -0700
X-Gm-Features: AVVi8CdF5Yb3z_aT9Z2kMSch_xL019u4GW2x7IgXTq3gEFLOWfvUzwhUO6mpfb4
Message-ID: <CABdmKX2oG9m316hiJpSXbujrT3vgE5hUpzH_WHfjNxBJ1_+BdA@mail.gmail.com>
Subject: Re: [PATCH] selftests: Open /dev/udmabuf O_RDONLY
To: Jakub Kicinski <kuba@kernel.org>
Cc: kraxel@redhat.com, vivek.kasireddy@intel.com, 
	Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 6:09=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 25 Jun 2026 11:15:55 -0700 T.J. Mercier wrote:
> > Write permissions on the /dev/udmabuf device file are not required to
> > issue ioctls and allocate udmabufs. Applications should be opening this
> > file as O_RDONLY. The BPF dmabuf_iter selftest already does this. [1]
> >
> > Remove the write access mode from the drivers/dma-buf/udmabuf.c and
> > drivers/net/hw/ncdevmem.c selftests.
>
> You need to explain "why", too. Why change it if it clearly
> worked for everyone running this test until now.
> --
> pw-bot: cr

Principle of least privilege. Folks use or point to these selftests as
examples, and then wonder why O_RDWR doesn't work on systems where
write permissions are not available on /dev/udmabuf.
