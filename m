Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5443B6BF1
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 22:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779833225; cv=none; b=bn5FefC+jVMjI5AJLXjM2f+rMLF594rTKgOJq6fWxP3t9Y3Pwau+xLTKxlYmaMKvkEIACf8gmX6YGQUE1RtMrghflSbSv2NnOpUKJktD607y+ah/SyZp+Hhe8B3zQ9/wnYrnkRYcoVzUIOn/Nyzy+AVRR0IqowtkML86HsKJtXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779833225; c=relaxed/simple;
	bh=2sAK33zF3O7UnpDrhLVKxL1N6rkcwS6JytJQL1qq5+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+Ql58erFDqQauE/FhJSgVKW71J+4wi2ExAw9mgauQiN28LfS7CEqdd6lsy+zsnDxwUSPBbHuT04T/Ma+U7FDGFlAYnhvlFo615IhPsgL7PjMfNMm09EfJcT3n8lxdsrHZn61K5KD6yVukg78K+FXm6AKRWm8+6nloJuqMGZOmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NH9i72UF; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NH9i72UF"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-44c350a5b87so6577009f8f.3
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 15:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779833222; x=1780438022; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0z6J1iKZrTsnsU17iSRjv20Zjg/emO8a+SYNyUR/BxM=;
        b=NH9i72UFnDthBPBpnqPQFPRle3aquPw51YcDdOOId7f9d32wjuoAcrUQG/796Rw3lJ
         VJ9LRa1DJCIaTMJqVL+TdMd42XfAZKcH4vPM9Ydn/Y+CiiGixWttVYsHcaVjZd9nLkyU
         gCcVg8UJu95avUPSbsenFtaa5fQn8qlGhTqfl6GCnV5SOCRzKhUORg+R5K9Un+APNpVE
         IsiqXKYuYs69fK7kC6MmuTP6/viQEQXfuhEP0+M3gckxN/0n6oRMPpmPSGtTxkNEFBea
         ausB1GtRkw7/vF3MoMlkq8zRDYuWQKIOsfCKPJKVFR0NmOkRyAZXvKFdHT+5D0g4uB/o
         i6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779833222; x=1780438022;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0z6J1iKZrTsnsU17iSRjv20Zjg/emO8a+SYNyUR/BxM=;
        b=X6J8Xt0IDGq9mT3jE/RmWhMXd4oLIlkxvRYKd53iv1kkPPnt1uTdWDR8l1Dp5Gjvs/
         Uhx35ii+ucvV5Nm7sMvVpAiAJquo6cKyFwlBQMlBJVDs50Pd5K9l+C2kqASI8G8laatS
         kpKVbrfi7strfQUb5CJbNXnHIaLFzz7rlLdgGKi1wgA2aCXdTXnJMu8HZf+s61VHxJqP
         8eUtSprzgS7ml54yR80SSApPq0wpOTO6A8walqtUU/VsStlBfqG3HUq4MJusa0f6+h53
         FiIH6khMXwpshPlZ/4/eD4bxXFv88G5tgEubc55q9isO8qE+/bztMkmQOVf/WisotaR2
         bQ7w==
X-Gm-Message-State: AOJu0YxrWxhgjbWHAHPohQ9ER69fiMM1It5M+OhbQhV5iT3P7mR8lpPK
	/owk8xt4FAATWgam4zaIOKJ3eXzZYWIRFKnCBfhQ7hvakVgzdifcFpxJtn9fBApi4FbFaA==
X-Gm-Gg: Acq92OF4GtXuKhhL48Tf6H5/YUkan6h2rM/jzz86hAkG7xG7t9qidwCkxItaadsUk9q
	AdUlm5B5qq7JjX6m+2eGpYI1PyERwWEFlx/uIXoBqTwjCpuFVYlVca9ggg3NPK29AGw/FwGMRdS
	uuLXLQjmluXQSVKQZ73A238X7dexylHYynsrku176v6iAHiO40RiaWpm2fTg8ga8XPu3rBgylyw
	qku6nxG/CuGIEAvtkX8XW4pi0XCK9zrPpvlHTmSKdOBnf6AVb3P44TmkZtzkIoMAgOAe+ZcaWsF
	aItv4z/HLu6He1uvsLvXWhGaiJaVTT2aM8IXAGH5m84dWb92z1WYStZbZqxWJOtuu5/JFFemYWw
	OTqm5LpCwm8eZKJ1lty/+GylSONbNiEYtTMX+/y9KpKf6qsNQdXsHY/nv8tKpjAQvy914Qv4QNk
	iM4M2bKvlA4jzMALbBjX35WOTOmH84I0MZRZW3g3WYyohkrWwmig==
X-Received: by 2002:a05:6000:4684:b0:45e:d843:27fc with SMTP id ffacd0b85a97d-45ed8432acfmr4747470f8f.16.1779833221703;
        Tue, 26 May 2026 15:07:01 -0700 (PDT)
Received: from gmail.com ([2a01:e0a:488:3510:15a1:dbd2:86bb:c4e9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5a296bsm1117421f8f.21.2026.05.26.15.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 15:07:01 -0700 (PDT)
Date: Wed, 27 May 2026 00:06:58 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v7 4/7] selftests/bpf: add bpf_icmp_send kfunc
 cgroup_skb tests
Message-ID: <ahYZgpQR452LBeP-@gmail.com>
References: <20260526153708.279717-5-mahe.tardy@gmail.com>
 <20260526192443.843F11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260526192443.843F11F000E9@smtp.kernel.org>

On Tue, May 26, 2026 at 07:24:43PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Multi-line comment does not follow the required BPF subsystem style.
> --
> 
> commit 67ff0f6d65a210627d2fdadf8ec80c32d95d6a59
> Author: Mahe Tardy <mahe.tardy@gmail.com>
> 
> selftests/bpf: add bpf_icmp_send kfunc cgroup_skb tests
> 
> This commit adds a test for the bpf_icmp_send kfunc using a cgroup_skb
> egress program. It verifies that ICMP unreach messages are correctly sent
> back to the client and read from the socket's error queue.
> 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> > new file mode 100644
> > index 0000000000000..0dc6b6ceafb4a
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> 
> [ ... ]
> 
> > @@ -126,10 +126,10 @@ void test_icmp_send_unreach_cgroup(void)
> > +	for (int code = 0; code <= NR_ICMP_UNREACH; code++) {
> > +		/* The TCP stack reacts differently when asking for
> > +		 * fragmentation, let's ignore it for now.
> > +		 */
> 
> [Severity: Low]
> This isn't a bug, but does this multi-line comment follow the preferred
> kernel comment style for the BPF subsystem? The style guidelines require
> the opening /* to be on its own line.

Could fix this small style issue if required.

> 
> > +		if (code == ICMP_FRAG_NEEDED)
> > +			continue;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260526153708.279717-1-mahe.tardy@gmail.com?part=4
