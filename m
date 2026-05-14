Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA6623909C
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 01:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778721053; cv=none; b=ofHhaUYGFZak/BpWgYU0DTfMedvb71lh6vGGDpGiYfWzNNOlnLdyKmLtfIyd7NwkG1riVN8Rpv9a0HTNPnXya10E0M69jXpLowsJO02zA92XpxkJJm9ZyUtcgmhN2rWsu1zPHf0WQQG+6OfcRp3GBAm1BUEWHuYzb5G2h21Kbzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778721053; c=relaxed/simple;
	bh=VP3E9xUx8K7Col3Pkwdri9YzaBLNytwsRXbwapHgmg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p//AxKuCMf835a/X2yF18dTN7+2rRE7YR3DRGYwXiPNbAwu3R8xGYadAQ/4zgDXC9AbeavN2fjZjQ9FtmlC8mxLvzxnTpo0SfdxvpROBHfEL0EPbj4Q1Vk/uULy1ZwLDOcg3mScWoZFtl0UQJL7eKCNFYnLQM1HQ2cO+au3dsjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pgBFpkYi; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pgBFpkYi"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-132cccd3d77so2834c88.1
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 18:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778721052; x=1779325852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R2WKg/pR8Yeus9hdyn0q6rMO9ZX6fRv9ueAaRc41apY=;
        b=pgBFpkYiynp5cO1PYqTer5mJHfSlsHS9DyTS3rpWHx8HenhwWwanQyNHowZJibg56G
         TIpR9TjaX4uk/z47l3DMYX3eaFTqQxYgqlw8lGvckIxtEQOBeoHI0TcwdgGwIt+iC2av
         34SBFIjP0ZLyj76tmt7SI69CJsVE1hmZOtIUiDuX+f7ac2t0YQ7j4cMWSZb/GQae5WgT
         YiQjCRmfgW3iVM9ACWIueB+BmpjoptF1xNaq4BzTeSUr5AhSjZBBjpMB8LS5NCWmvsVM
         SHKp3WXhs8xJ74UAIUwD/XjJY7yXK7hsIYVuVBlTPRlZd8NXEIuse5trPK4MsiQvWjMB
         Is5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778721052; x=1779325852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R2WKg/pR8Yeus9hdyn0q6rMO9ZX6fRv9ueAaRc41apY=;
        b=rifQPz/okaCWX2DDf+t5XdfUUj0lJP3FDix9me5cwQ2e8Haa5Rw0TTdpqlRJhQFJow
         lYiOZBryLKXG7Ppi2pmkQfjExenXLUFjy1IAv2gPCwJas/68/9QTitSYUIWM6F+fRO+1
         zgbhcF/JSNvmn8VZdvQfg66dWvxlXdqsVX04kOkE2eXubCbZTVpH4CKCCS33baY36D3p
         W3T4KHegFpSuOF3dU9f1fMY2SDQNCWMeCHFcGQASAwxnkNlN2bbUHs3WhbcJNtJk65Tl
         RLBADuZ9wnlE4yPjdJ8aZky0ocRbgImKUfZwLdvynfQrmz3f0kTbykyitqBY6Gnu2Pio
         NSAA==
X-Forwarded-Encrypted: i=1; AFNElJ95uJTN77QO0nhWdKtmbgOTwC8voQEi1PsDP7iITpi244W2AQ+Q3T1tKMEDGarSk6EyYu4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Roc4PBTB56r1gYQp8OR+zqS7AP6Jq+N3OfufedvhDydivE/E
	Z2DOyMnZYZRFK4XiiXB5AhZegG7yjzT9FL+TaDgVNrW6hADZmRUdfxpvAjG2++wDAg==
X-Gm-Gg: Acq92OG01FJBq8zH7qwySSu0Nq7ADEYCV6vv4lkt7OuxYe/2yzbjdLCb2H4qWelXmdn
	7TIL5Qo4DLrxJK0fKPKNCKKePY0pkn4w7SjJeS1CEcTKvAJW8MraG3sP+ji4jso1B9amkDk7VAd
	SXDgt5+d455L5Tu5Zh+GzR6n07sAk+zW/Q+y9Y/W9vTItfsI9XvmGiwyU0tRKt/REHUYxD5NmP5
	NySPmpuq4jLygXn2IAnZHuAU58SBADfC4dgJ2AXJUdePX1cl/dTCUc46wEO/cNSld/GlXUytNqs
	cdl0A2UZtRwrUTTWQXT1GfH2cMeIkBtlrU+obCAF6BN9pXPaDqrWNspuqsquN/OkY0uRWsPGe45
	v3r4JStpaOWj+AG+HZ4COxCJkezGDbCdfbviZ5QS93MHDeK1CP5VUMy6Kn84fakYXev6i7oK1EX
	0MUdS2saDm37wgcirTHfN/yVu3CetZ9YpBfBk1hDlGMBqueVd2ELN4gcRUVtFZpQu70WOIz9eiU
	FCAhaYQNWfMdNM++Edc/6S8CdkcQ1QkBnHvTGEir7R8oZvHPBKSOcSH
X-Received: by 2002:a05:7022:390:b0:130:aa42:16a4 with SMTP id a92af1059eb24-134cb46979amr132599c88.6.1778721051076;
        Wed, 13 May 2026 18:10:51 -0700 (PDT)
Received: from google.com (112.174.16.34.bc.googleusercontent.com. [34.16.174.112])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30296dcc458sm1452388eec.18.2026.05.13.18.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 18:10:50 -0700 (PDT)
Date: Thu, 14 May 2026 01:10:46 +0000
From: Carlos Llamas <cmllamas@google.com>
To: bot+bpf-ci@kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, memxor@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
	john.fastabend@gmail.com, kernel-team@android.com,
	linux-kernel@vger.kernel.org, andriin@fb.com, bpf@vger.kernel.org,
	martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH] libbpf: fix UAF in strset__add_str()
Message-ID: <agUhFgtZlqw6-YTa@google.com>
References: <20260513232055.1681859-1-cmllamas@google.com>
 <a183ee082f0d56ee7664ad0d13cf7b7169ed2b6da743cb332f619fb360689ada@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a183ee082f0d56ee7664ad0d13cf7b7169ed2b6da743cb332f619fb360689ada@mail.kernel.org>

On Wed, May 13, 2026 at 11:55:53PM +0000, bot+bpf-ci@kernel.org wrote:
> >
> > Fixes: 919d2b1dbb07 ("libbpf: Allow modification of BTF and add btf__add_str API")
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> 
> The existing Fixes: tag points to commit 919d2b1dbb07, but the bug is
> actually in strset__add_str() which was introduced by commit 90d76d3ececc
> ("libbpf: Extract internal set-of-strings datastructure APIs").

Yes, the bug is currently in strset__add_str(). But it used to be in
btf__add_str() before the problematic code got migrated into a separate
file.

> While the vulnerable pattern originated in btf__add_str() from 919d2b1dbb07,
> the code being fixed resides in tools/lib/bpf/strset.c which was created by
> 90d76d3ececc when the string set functionality was extracted into a separate
> module.

Right, you are making my point here.

> Should this use:
> 
>   Fixes: 90d76d3ececc ("libbpf: Extract internal set-of-strings datastructure APIs")

I would think the commit tagged as "Fixes:" should be the one that
introduced the issue and not the one that better fits the file name or
function no?

Another idea would be to tag instead the commit that introduced the
specific pattern that I ran into, which would be commit 9d199965990c
("resolve_btfids: Support for KF_IMPLICIT_ARGS").

Anyway, I'm happy to use any of these. It would be nice if a human can
confirm a preference though lol.

Regards,
--
Carlos Llamas
