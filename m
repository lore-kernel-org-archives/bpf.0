Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795051789;
	b=Z6Nr/hLae9w0V1WM+qJDgDavA9z6cyLwcKi9satOg4QpBnHew5aUHtGfWutdE/a8olND
	 aqqxLIeJWlA9FjEnDLk6oFX6Xrp9/Xy34xvNJ23U13+RDnIZw3/CVOhPz6q2nMANvBGkg
	 qaaslEFEDcS5ycVx+NZNwkYDI4QZnmftYpVd7+NcXFVveCu3pew5MrLf97BVfDFGRAZrC
	 +UU8eIZnmXMfiAgqgewF8xMBWK84iMzJNeAUwV8OKaSWfcjJxHg6lwlmbcl8i1mI3LS/p
	 MBYjKw/jh+FNBiaox7nG8kqVPuo6tU/Wxhm46qRaezO9WbhPCIheQkYal1VzYDz56Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795051789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=IMUfFg2iR1Z91GxSjPkov61aiB2ViYWc3Z9M9ZmX54Q=;
	b=fY5WNy36tkeKIdpIcpeBGNDz2827IvnvmwPptHWHv6YIuBZeEpDotGajnD1luZ/h5sm9
	 TsN0ngvy5oYbdmN7wi29OMwHLTx/bBZhXIXRb8fMVGOzy7FxT4pSppupWe/D9qxD3ZVnT
	 bt+QSHrvnGD+bOyrS9REP/t/eknJJWM1d30ZndOudyAh1eJXIJ2kjQ56DeCnbNBSz4hAk
	 nONQWl+VW5Ho53YnY/pWXxDh5ZLi9T2GZGsT5ZjUDsN2/jhpZalZtrIaKVJaq+yFPBylc
	 4tBC8O3rSaU2tftlgc32+o/8lbUOditxPIOGJx4vIFyfG8EcHyv2wPx35xcKq1VOscw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=X6RUl5nX;
	arc=none smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA41606A325
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 01:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CA41606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=X6RUl5nX
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b8b20b2538so1161977a12.3
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 17:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1795051787; x=1795656587; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IMUfFg2iR1Z91GxSjPkov61aiB2ViYWc3Z9M9ZmX54Q=;
        b=X6RUl5nXPwSwt5c/kUdF+d/qAIPpu4B78KXEgoYgO1Ifwmp9Un0wXT9O03brHfdkj0
         Iw/NgiWtHQkg9OjzyksdTG/Yk3SubNSObINPdaZ1LH3tMW9lWXcM2a5r0nkclDrg2smC
         Zb0YGB4IT7dNKxmFRti4PmVmxBxhrgJIsbGdXjpReO5gHaAFEaHL7kPg6Eg7L+Kh2w1f
         9UmlkTUkG7mvaMEWNHvsqbuMBWDQO8hWN6c3xb4rEMyQKIx7BNQiPLSzNI0tNGSeJsfo
         60BiL735Nn8IsGlBj2912I24qTnwkLODMQpnOlSR6NzHZK8QstcQRJPAG1XWTsTRcE5b
         m+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795051787; x=1795656587;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IMUfFg2iR1Z91GxSjPkov61aiB2ViYWc3Z9M9ZmX54Q=;
        b=bJHo3lyXuJGb1csr6tYBOQjFd1H5bs4k0eor7FxQW5XFJVufGoN2WZZvniFpXkyp3R
         HpaVWU8oKAf5JnmeBTKxW1fxG6hsBAfu6k2JS3JtwAptwL2VD5mX2xTkR1sTDa8nc0nu
         nLKsaH83cPrYAxPvT4Wxjt6c8qGK9X0dPdHXFTz3urB9+jcFXPaKCAU84EbLzPZL1beG
         e7F5qcF7lN0myhvUi02YgRmhbyCcUGBjtP20o1gN8RAf5W4hK1V1R2vwuNai4ivKYCtd
         edMYowfsAdCfJ9X4xVs3DnjkFdlSDQpixzCkzgiY15NcMsJnwuwCDXof+feCjhfHWiPT
         4BOQ==
X-Forwarded-Encrypted: i=1; AL+hErGj0cFWX4SLX4iRZM2MzEoSFGf1CXuIcRjDjAT3FCkNGRogl0H/cjXXPI6wV6r9KRqCh0Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z8HVbYdNKVa/Ic78y5x0Y3+VebyguCFB9hRMSyI3X4NihsfeM4F
	54Rg5JFC2S4wJKcQb4tdsFP0+p+yBrTG0cvfRcBiBOdiCKtFsCqU6Yfww2HslmIK3GU=
X-Gm-Gg: AYBFou3xxx6ONC+8bKIpPVKTFqMfECgTpWkXNuURdgFDZQBwgiluzmth5E5SOkJ7BSB
	GvA9nQ19QNEI4okmifYHBljEYZ2bDgPvN8Jf776vPhzNq+TGvRh9IxfOTTHiizt6lu4kIVaczRs
	sRzmjt5I/ESL5UVu+3BN6ToglGeKGHgZVYdueIrzn/5gHcjIyDSte5vMdHmfyhuPk9sCZTzARZ+
	m3J4/9ZBBj0iFQMAKJWTVOynoipsD6p5088WDDXscaU8gn1sAIsUHoSi1EPIwKKl9wkDIN356o8
	Z6gFbtBlGV3BFgoKQYfqMJqYuklr0RXGRiPaU/bAm6484zpBcq7LdjOTsf/2YLNLuwdnw4Ii1CD
	C4Xrf/HpYxTcjcvfcr7LM6yqlgX/2tCoQ5+kMdF4zHTwr104pYydEFfljgbJhuRORzlbjf5gOzh
	LlzjlN6oQm8G1O5sJc/qxA5bZS2AIcUWUeTBjnNgQcMeZmOU3MdK2284Pcak7SJ7VQK51Ob+Q9X
	hHjEGde13D9SMycLL5+yfJvwYIGIyRClcpk4hSIo5mH152aALQ2MZlJNsm+eXuhR3H6bJcxqJl+
	7uGnoQf0KCm1yWpSAytToza1vRnL4yfb4b6zSMayOCrxmPs/VDayGDXscg==
X-Received: by 2002:a05:6402:c4e2:10b0:6b8:afbd:64e6 with SMTP id 4fb4d7f45d1cf-6b8afbd6722mr1777470a12.42.1795051787085;
        Wed, 18 Nov 2026 17:29:47 -0800 (PST)
Received: from L9JK9NPFH9 ([104.28.20.56])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b88a1eb813sm1711016a12.26.2026.11.18.17.29.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 17:29:45 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
Cc: Hangbin Liu <hangbin.liu@linux.dev>,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	skhan@linuxfoundation.org,
	kernel-team@cloudflare.com,
	tianyi.gao@linux.dev
Subject: Re: [PATCH net v4 0/3] selftests: net: veth: propagate check failures to exit status
Date: Thu, 19 Nov 2026 01:29:40 +0000
Message-ID: <20261119012940.32838-1-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119003003.40482-1-emmaonana18@gmail.com>
References: <CAG4wq-d_30-B4wQZu48ZQXAORM4QxRqPfmYsmoHS0hiYp1EtTA@mail.gmail.com> <20261119003003.40482-1-emmaonana18@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

Hi Omokefe,

On Thu, 19 Nov 2026 01:29:59 +0100 Omokefe Emmanuel Onanaroghene wrote:
> Changes v3 -> v4:
> - Patch 2: use if/else instead of "&& { ...; } ||" chains, keep
>   lines within 80 columns (thanks Tianyi for the review).
> - Add patch 3 deriving the invalid tx value from the kernel maximum.

Sorry for being annoying, but I see three problems with how v4 was
sent:

1. Patch 3 lost its subject prefix. It went out as "[PATCH] selftests:
   net: veth: derive invalid-tx test value from kernel max", so
   patchwork put it in a series of its own [1].

2. Patch 3 should come first. Patch 1 makes a chk_channels() failure
   fail the script, and from then on the nproc + 1 check can fail on
   a correct kernel. With the fix first, no commit in the series
   reports a false failure.

3. v4 was posted as a reply to my review of v3. A new version should
   start a new thread, and its change log should link the previous
   postings [2].

[1] https://patchwork.kernel.org/series/1215530/
[2] https://docs.kernel.org/process/maintainer-netdev.html#resending-after-review

Cheers,
Tianyi
