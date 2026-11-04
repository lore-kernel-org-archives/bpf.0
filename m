Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793754360;
	b=paXU+IXTcgNqWTZ6XP+OmCOLVCllxM+XLUvSk4nr8SggZEKyJH1yIUMpUDh9LB/29cKf
	 v6rTrMCIROnl9q8g+6FjJg7r/F8I/KnerLCE0IvSZPV9iQ8tKQwj+BpZNfuq7IuWUcehO
	 KV85RhSKkh5dz3B9h9NFFCWgVK3FIqWKC0hyhPM0ykTJSkQwS7cr7RuT6fmlOk1/NZFdU
	 z4r3onrKLU0XXzqLB9AGwizn/iXmFuvliA3XGj22UnRoXrznaDJPRs0HfLUJnGPGBBXcE
	 w3L09ldUyp8bDnrhM/FZDIocJRvOr9yb6vryqMV572C8nJR9O+M6yL6aegpIavNwEnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793754360;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=dqWRL3kzjldEVQsytjD7h2NlJccwDqbt2iS7/1Vy0To=;
	b=jx13xBGgWT4geguvCEnajcTP433/VTpnI3wOAjSeJGJVPTMSxVfl9GQQKxe/tRqkw47H
	 f4bVJfXdkwmnmFYxu7bho0rExgr5eoCqKSIRDoqPU0fBPnRaYwCLL2va/itI1mslSZY0i
	 sBtIJKI5iFEX+PGxlQk+z3FrkVHO+c+kcav64c75XpQVBR1xYqpxzkVx1CgCk4pJMb/o2
	 pmmS5trSEW/mYDCyGimRcDlzu6bT2eusPODrb4DSFd+ZZoAF29DLtXNgw84Y+sdae/XCE
	 NS4LjdMheHvOt47XlNcgkM8FwKJzu4QoTzKUm/vHBq5WjFAmz2lcyvTt8HCRzrbvanA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D9Wn7Ccl;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C436606A31B
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 01:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C436606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D9Wn7Ccl
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e5fb79ce82so656275ad.0
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 17:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793754360; x=1794359160; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dqWRL3kzjldEVQsytjD7h2NlJccwDqbt2iS7/1Vy0To=;
        b=D9Wn7CclllagH5DeOF4nWBpU2GGeJIb+tj7sWepx1l9LdcWMOSqf04TjfCKrpR7UzB
         nTaGgE74/aoFYOV1nHe5l/tQLc5x3HXX5Tcfs38fA90QQrnL6ss1d/kD0oeFaCapGPGR
         uD287LxqfkPIfYQVLHcUWVvxoyMnirrgCWotetk2SjJQ+BSBRO7jXYHZXWlXch4fSKqU
         bgtk7Sp1pcqA/NfjZ6wt7DpEuQVyLFTeoB/fGXZDYT41WLH0vGOvk6GxDcjxOOTSi/Sl
         z1x/irQIKx+/U+xiGXFo3DYMKMhumzQ49yR20QRDPcWD23WI/Hz3iqqhDNfcEDtY7BLj
         LJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793754360; x=1794359160;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dqWRL3kzjldEVQsytjD7h2NlJccwDqbt2iS7/1Vy0To=;
        b=oJhvglJh/rdywbrFy92xarQlX4mc7L9dVVdem9GPBOL7jsAYnVddsrcrnR013In+CU
         iHE2JF/KI4D24cC4LIP9wkMYxRLsreekqw+8gwPAlVY1rudxQASAfYpfXlBVmxPxrpLl
         9GY20RsVu1VmyJrq7QAILabSqy6ldeqgFPqJcrsi6kgvlzi22eQjhD0tUW8yZplyGusD
         pHrgTTYurMrVBOM9jPtq4kX7Q2Zmbq50MLXdTv0LoU4bWOiPYK18GZ0riq/nIgA116FV
         0baz7ktg9yC4X1oWpYGLznRRSb3IJ+2RSQdgnpOR9p8tHJZGCRm/GSwosz5WstrOrwRe
         LhuA==
X-Forwarded-Encrypted: i=1; AKwUvBxpKeZf5Ke32Z3DjxB7KtYG8ssM4an8lvXi17BaaHySeBZcpghmA/PPTU2emgpaVVCjfZY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/oD1/X//iGzldIxJNUOjv7It4H0DDST/X9kgKbTx46MlXkLPBs
	lu/E96dmRFeiDKrblLJ/aA/ed7RB1tDC7SSynm+FsjY8kpu9KP06wGcpOtX8+w==
X-Gm-Gg: AYBFou0ggVvRavHkH2se/mJzO9aZy85aegSvsCUgwib53tl8g+3wIH3j1wHu49FbkZG
	uP4ZpJXyE/icoSixufZUPbWmO0ax4b5Lqo6mWC48LdiAnTMk4bnyVVa1U4dJ6CpgnZZ40B25dcj
	8vq7FWtL3CeqtHs8XEbwLokGQm7KqT2zw1qkRNk8Qcc9yuZB70gz9/GnoiHAIPr1+Y/U92WgnhF
	iDqKEBq8fMDOgGg8MZxDGp/X+sQwLrHqEi7IUP5sCl5noMCuQ6JxJVif8/8wO9/R4+4w+m7vcTG
	62p+dy4dbQZkcwbyWKxk63IQCckqVKYNNOahIe0rOMRaP44UOWwHkytdt33XLzGZG/s+cgOFsTN
	8DqNYuvKczewJQi29hmLqwWIVH6KE6jAJg4He9T87eofE3V6k9nrbj5StdMq4pYpc4ReuBhpYkv
	djOLAZ7A6bOGhixeQ/rV6MKtL3Ilf3ezqQEWrh5bViuQFNPW3V2z5LN2duSfIBio2OD710T3Za+
	4djpJNMQ1rlWLSh//snb8bpLTnG/W7/Iy7MxOrmxtRSDMCao5YMkOZtMYkjA7KfmJuxHPKh9JcN
	1pINjZ+FF5NvZ4qPRSwi0LzZvjaa6yJqonEqSLlgrX7Xpn+G5mwqfAxOS3IRaWQ4Gqk06OHM4ln
	4mYUDfJfDGqnboiUqRO3x5TDAUqwFuLhx9Q==
X-Received: by 2002:a17:903:3905:b0:2ed:948:b68 with SMTP id d9443c01a7336-2ed09485cf0mr4864445ad.9.1793754359453;
        Tue, 03 Nov 2026 17:05:59 -0800 (PST)
Received: from localhost ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed08fe4fc8sm683015ad.16.2026.11.03.17.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 17:05:59 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 01:05:58 +0000
Message-Id: <DMM0UOCXG7PW.3UKUR0B47193Z@gmail.com>
Subject: Re: [PATCH bpf-next 16/37] bpf: Count loops whose first value or
 bound is a range
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, <bpf@vger.kernel.org>
In-Reply-To: <sashiko-outbox-196303@kernel.org>
References: <20261103234104.208239-1-alexei.starovoitov@gmail.com> <20261103234104.208239-17-alexei.starovoitov@gmail.com> <sashiko-outbox-196303@kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Nov 03, 2026 at 04:21 PM sashiko-bot@kernel.org <sashiko-bot@kernel.org> wrote:
> - [Low] bpf: iv_bounds() leaves bounds->r32 un-narrowed before log_bounds()

Not worth a respin.
