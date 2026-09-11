Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F296C49E5E2
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 16:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789143208; cv=pass; b=PEltYDzsqVsvhN235qn9XiryP2OwowS7yvxPvXlzY/xMOjeqXOYbW0Etpa/B4kQrIc5Wl25CxIW3vx1gt/6VdbUzaOnLkB0PSAqIyBNQEOBzCoOGSbSASXtPYlo1h5gAqLgYFXPJ4+vs8ksxdUBUJkjMmJu2WkkttSFJG9z1hqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789143208; c=relaxed/simple;
	bh=o17OeanR+f8874fxRxAb9yjoao/cmBs3eLzTOvMjtJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hU97g4WYxfhUkbk0//exo8kYK7gmUDX6JevVRqcsftpAqUVCDFGzhWaspf8EpppHw5CMiAqJ1ZhLmanhZA+kJd0kzX1rwgF0vEJ2ewOJ+r7MYWfUfuEy96E4PbeMSZWamdkE0sl0lAuzA8KgyIxxdPQjG7EVR38xlbjqvorM5g4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anyfinetworks.com; spf=none smtp.mailfrom=anyfinetworks.com; dkim=pass (2048-bit key) header.d=anyfinetworks-com.20251104.gappssmtp.com header.i=@anyfinetworks-com.20251104.gappssmtp.com header.b=RouS9B6D; arc=pass smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anyfinetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=anyfinetworks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=anyfinetworks-com.20251104.gappssmtp.com header.i=@anyfinetworks-com.20251104.gappssmtp.com header.b="RouS9B6D"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-783fffcfb96so812327137.0
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 09:13:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789143206; cv=none;
        d=google.com; s=arc-20260327;
        b=ryou5xQk41Sqkggk2odPxgFq6GqPOEAp5J5oLrWBFcsPmHM+sW48ZbTEdS99gubZZp
         XwFy6qvf3g8QG89KexWKU4cGeYKFYnUXP3C11SRW5/5egf1GdaBtTZqh/MqS+6jS5088
         E9mMeEQZLUbAIK8qryOqh5t93xwjFH81qop8HxAiuC33Rmzt13xMzgUgA+PV+UN1LnG7
         le2XfiHkF4cz13BNXwgzIh2yDkbWGzDthcnr7N/vtXo+G2MIFKlk5lo9vq+y1vdhhL6u
         hPW8SZzgbY8hca8Py0TH0imRHwJ5I+qzD6CsiC7ls4ya8EOA/ocNwIsWSX3vGxuLbw9w
         p/eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=o17OeanR+f8874fxRxAb9yjoao/cmBs3eLzTOvMjtJY=;
        fh=ZX26aBAfVFYvHkrokpUDfMknRrdGaaa8gjvyUzAl23o=;
        b=L/xAha99hg8mQ32DbZQJyxrXTNU5ypQDyKkX0ptV+F7xFF2IPTKsi2j52/vSGw1ORu
         SowPaNW99Wf+jDCLk5iT3cNrW7a3IS8PZxt1carzplv1rl61zUbqpxseup3JJq3CoBLR
         5CIZe6yTKE7hxwLFRoIlHq0UIW6KeROGdfD0Wr+4vBRoOgJWJrV59m45uQtCGT7cmTur
         86A/BXr06ZrEsM0HTDCEFWbtPGPy4Q1vRtXMCXyRCjuV1FIIDOqaawEh0kXFP7kHqe6L
         Zg3eZMG7L9/s8ukuXkfUHLzIQ8Jfblbo+Mzxn3QEQX2p/Upr9/wpAeo2CB5sQ0EnmTCz
         hQGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20251104.gappssmtp.com; s=20251104; t=1789143206; x=1789748006; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o17OeanR+f8874fxRxAb9yjoao/cmBs3eLzTOvMjtJY=;
        b=RouS9B6DFEUaKzfWu2e8eLfl3WhQoJmYHtf9Baul7Z5mnvxjKCyR7XdW65dc5AxDl6
         ivgb4GF0+J2Z8gxYbt/T+OaDZFYCsf9Zemw+lUanxgQhtJORECxSbnzNDMQMRDz2QmQu
         kKIrqJuJq6lzVhLhDVdZnqKfVen/lbn42JUx/jdcTsBbXy37xFtUeCqvnuyvYQz9urKf
         vT7lCDopn8BqAw7y4yEQLc65f8lY/yv0EubwDGZa4Mf81kzDuCNAQ/7Ib2s87N9Op4Gt
         2UIfrc07Z+oDqSldAlsM2eqhDNH5ngXhQIqL+cs5/CAbvu8Vzf0UR0bOA5rZcq/0Xc+g
         mtiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789143206; x=1789748006;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=o17OeanR+f8874fxRxAb9yjoao/cmBs3eLzTOvMjtJY=;
        b=q1sZnvcPLx+eqH22c9Y6aM9fTTSQJHnNc+yohZCSLMuig2YjvVkSuuglGqHnEOE6vJ
         gWrI6Bk0Q+asgYyTqWSycOnumE/ZHFfznUffOrIAiGNdR4OmS0bgOsd9sN91Ov+NkoCB
         VDt0aJrJ4O/ITKJnKZaOx8ozmBiuDI4NkpA/vaFueedFI91lqijboqLea7XiWX4TmFXV
         3yNN932FHU/rsHz6GfcjRL9uU6njYjLFqE8QIf6Ggsq5cjtw6QOo0gXkEuLc5Q9eFo5/
         sN/syVq3f7hwBTtEJjRw50pDE+8LOmsKKaYAdSvo5VwcKCbmLKNTk6HpRaDXWn5ETwbJ
         SR2w==
X-Forwarded-Encrypted: i=1; AKwUvBxZhVDqoj6fylKLp7EkcumQlf/ySz++vRy+P1s/fGGGA+UKGuZSQqoaUpwwWGk+q+dUbTI=@vger.kernel.org
X-Gm-Message-State: AFuF++nJxorr6IJjlbM2wB2eCLhlhlXS+AHrlVNGszNnhKxKHhf2jh21
	ls3xL89qyyvMI7prON0wrQ1ZgF6qyKniHWQFRv2da7nJ/CgeBfYJxVXAj0qY2R/mr89iv3HPXzF
	VNPQ261wtpvQvZoHqWkpXMySejNYZWp7N2f9bQg0IoQ==
X-Gm-Gg: AYBFou2KHfCRym9VpEfw/1azZR2hXsQAUUOM7LDiCsyTOXwZWxWQMX7daJo7SqS5G5I
	eymO6zJKS/Ki1dAm0qDFXKaV6PxEXX4tR8n6sFt8K4SnlX5QlOcdqKKUf3MG5jrCIDkWXfKTW0p
	hd6+jj3I9BardZ+wiqdmEOpqq4m8/Yd8rq5XzqhLOqlY/bWsAhYisi4tVSL/brLRf6Y01K9kDpZ
	dZdwrSve+Uus8LeH2TaXVEU6iCTbULKPCEssmy7PXo5rVdJNDn0NzRBj3thdOFCXYi8KgxxoJ4w
	UBPcQ94uVKEze7K0SR078/8iaEU6yl8K1OzOHyVO5xrkVxoZ5H4Z7Pk=
X-Received: by 2002:a05:6102:2906:b0:792:6eff:ef5d with SMTP id
 ada2fe7eead31-792a7720e44mr6095657137.2.1789143205847; Fri, 11 Sep 2026
 09:13:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904111731.673341-1-main.kalliope@gmail.com> <20260904111731.673341-3-main.kalliope@gmail.com>
In-Reply-To: <20260904111731.673341-3-main.kalliope@gmail.com>
From: Johan Almbladh <johan.almbladh@anyfinetworks.com>
Date: Fri, 11 Sep 2026 18:13:15 +0200
X-Gm-Features: AcwNN1VbHRZ6nj8HZW_zIRxsgv26adD5RCqJN375Skj_Q_o6IqWmWlOZFQd_XPE
Message-ID: <CAM1=_QTN3JJ6jtckf32F8wxBzLDbHSrzUttyMBWNqZKmRe=2rg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] bpf, mips: Add support for BPF_MOVSX in
 the JITs
To: Nicholas Dudar <main.kalliope@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, paulburton@kernel.org, tsbogend@alpha.franken.de, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	bpf@vger.kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Nicholas,

Thank you for the updated patch set. It looks good, with one remark below.

> Use shift pairs rather than seb/seh so the lowering works on every CPU
> supported by these JITs. seb/seh would save one instruction on
> R2-or-newer CPUs but would require adding those opcodes to uasm.

I would suggest that we do this optimization. There are other examples
where the JIT can use fewer instructions on newer ISA revisions, for
example BPF_MUL (emitted as mul vs multu+mflo). You can add the
missing opcodes to your previous uasm patch. Then add ISA-specific
handling in the BPF_MOV emittors, in the same way as it is done in
BPF_MUL for example. When you have the full patch set, I can run
through test_bpf on all my QEMU mips targets.

Thanks,
Johan
