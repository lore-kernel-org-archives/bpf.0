Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793754377;
	b=mnJEtLOwa9xWvBXwbJlt5aB6lGjUteFjcqCSimRbPwvK8XIM7WhndefzZTg6Gaon8/Kd
	 uAQpargclhdpqjs5VshEBdIjmtAndaWCQQNgYtdK4i39YUNn/QRhkF6Q66kCP3Ch+LsbB
	 8MPSAqcpqdlLTIaAstjYZ6tGkDRXoIKWGaNy5kOcPLQsCZw0h0rU5o6Cn8oeXc7F4bp6/
	 iul7m1V2fH9A9wVTwetqaJB0Ou3HVJ9iDT49es3oPI+siQxsAkuhnJsb/xiMdQo5MjlUc
	 P5EIKx9TWnhuap8DFwNovaW11ACt0yxO4zVzGXgg/0Y7e3XpmHR14s+X41YfA7Nf/DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793754377;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=e/ZOJR6zfCMRRFgaVH1u8A2/xnBqnirZbIxroagefr4=;
	b=V7LhRQWPaGXBPLQ93tl5VYjWJWMGPORPD8IUkDsUrgMZjpIwnDA1HCKrYcYQd42iE/5+
	 +pNhOczRE8SgDgq0QYnmvDf0zilPp3i9o7EL3DL6HRb0J+WeVq6wzugqKvnJLdOjub/Yk
	 mnrbxnR9x5KGpeDj07jbbJ7Dhchi1N1WXgmokevbAJy5/OVFZ8YdG987BDRXIFX440rKW
	 C72MNxK2eHTVWj2PUVmQ3KLMU+xXkrHbyJ9e/ZIkGyx8u74w7KOICLI8b+SoTYlULwKT3
	 FP26AftWWGZ7yw4Oc6gDJCdpf0Hx9MbeD/eQfPVfhon0VZyKrH8wBbL3EI0e0mVPePg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jNQlx6vf;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEED606A326
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 01:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BEED606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jNQlx6vf
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3b08cf16decso159819a91.0
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 17:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793754376; x=1794359176; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e/ZOJR6zfCMRRFgaVH1u8A2/xnBqnirZbIxroagefr4=;
        b=jNQlx6vfGa9Uh3upFxL6WZfNJvz7Riaymby1T1YRhIUZ+7VwjK8psfTccMgdBF+iZY
         9z8ejGbWi3GJXcO9bGho2L7MaHptsPhaUv8PePh6oQwOGjj8mQN/+7q7EnQRaDyPRJyw
         sNtzdl8tbDI5KUkrJ1NaATbsbOQMZDDoc2wDY7yi+iNgAq7y8RenmaXRL2n6jZoauFjO
         5WdA9UGkBlpavp7fYS4e7y1IiNxXt78KtIIbtAx4M/qYLyq9ovI+VuyMDUTf6SqS5F18
         gn1TXvs2yTrDe3y9Fo8ioajhmt3JbvITgBHngaumcqXoWG2SwwRv3uIjDGujgybxgA8G
         IvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793754376; x=1794359176;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e/ZOJR6zfCMRRFgaVH1u8A2/xnBqnirZbIxroagefr4=;
        b=EgN8g2OmTB54JzpiejthPXthZR7q+gtOdw7KcWVNt37eFZt4y3AONMBakY+pwGglRw
         P9NJLXp1hlV/TeZlUc3bOZPCkokZHzWkjr7aG5+N4iQeN0ODkWQ1f6hpWb5dzyWeYlbm
         /wn4KtOWbLkp4YnJNT3U6M0Ofp716gv7EmyLN7ruo99B1z0oAsjLo5dlvn+cNh0yUIq8
         W018bhPZoFPWFHtrpeO4agpiFm//PFv2m4pGm9PPToeAxSrFXMfV4xtfBxsy3QvbUCZm
         IyoWdjnmKFXCZuM1dn/rF/Koa5wiBWSc369s2zKD1KprrvNPn/aKpN0JjZ5MFrbJPhlA
         OZBQ==
X-Forwarded-Encrypted: i=1; AKwUvBxJU1a4Me0sxSFfnKjBbIud7Cy9s6nBYbhWF9FkQFGSQTGtzcUg6oaHivT4ei5sEZ5YIwk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+x8uOW67v6qrYJO4VzbE4VSgfBotcj7OOz1KGrIPZgHXDJi/Ne
	aPjD2Xe0vPGqc3gbYkcnB05m6aRQfR6V07UiWf0fRj48wBrcbCbR5OnjQ7C0yQ==
X-Gm-Gg: AYBFou39aEetcV76LATsFLyCJsaC0TL6q3pT24Cz+jvqo8uVSab+tukr2DN1YOv+5gp
	UR2AUo8iRugUneve1ieNUAAnjLZ4zRNzqtBt8mGvrY9RLhB1PBjQ068qKhCDv5lc81Cu+LqFj8j
	m7rk5S+3uErTENvG2CGwm5oRqn8Dd71yBdt1TcLHPZOyK6RUtX6j7AzL8Iry+gxP89Rr7chqSf+
	IE47b8H6uxOw/GcmybVuNrHiu7zAdw5WXIxuikVuQGlJhSrrQR/DLR0gh17OEBKFQuEQn5WV3ty
	ABZyIBOKjs/ECH67tInJQtyvDETRMwOz5VoelOG3q04w141N/rpBRaBBMYJJH9d/sAiuuvMWsUg
	0UdsQ76GMywTcCnczhhgLK0vAMsd/Xpr8vlEUmcUrZo/0Pmj1JUCj1qUWjDe0RrvJ5B3vAddXgL
	9fidCfn4ZAiPa1KGUjhv0WsN/48pVyqoNLjwM7nQWO4k1v8CR+0eVLcVIxqG5Y6BMiKLXJ/qn6N
	XEqvxRMFaAYqfJHV1ObbAXbfgPrCg355NBUZLWXeDCOs67zx+W07nKhgxokK1t2101fkWknSIsk
	s/19+8LIkX7RH/Daq4NPewDs1QQ4+yOTrFsoqW2k9auRB/n1brGxTXBxYa58wLUpQhh4PqK7RrF
	+VQ29zVQC4gav+YpbyyIrBA8t28vk/PbS0w==
X-Received: by 2002:a17:90b:3d8a:b0:3ab:9f89:e1b3 with SMTP id 98e67ed59e1d1-3ae89764eb6mr12121690a91.40.1793754376342;
        Tue, 03 Nov 2026 17:06:16 -0800 (PST)
Received: from localhost ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b09451c650sm621686a91.0.2026.11.03.17.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 17:06:15 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 01:06:15 +0000
Message-Id: <DMM0UW4OALM8.2AATFMTT6BYRV@gmail.com>
Subject: Re: [PATCH bpf-next 29/37] bpf: Count '!=' across 0 in 32 bits and
 loops that go down
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, <bpf@vger.kernel.org>
In-Reply-To: <sashiko-outbox-196311@kernel.org>
References: <20261103234104.208239-1-alexei.starovoitov@gmail.com> <20261103234104.208239-30-alexei.starovoitov@gmail.com> <sashiko-outbox-196311@kernel.org>
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

On Tue, Nov 03, 2026 at 04:26 PM sashiko-bot@kernel.org <sashiko-bot@kernel.org> wrote:
>> +	if ((op == BPF_JLT || op == BPF_JLE) && initial_val.ptr_reg < 0 &&
>> +	    (latch->jmp32 || latch->zext32 ?
>> +	     (s32)step_val.umin < 0 && initial_val.u32_min < bound_val.u32_max &&
>
> Should the comparison allow equality when op == BPF_JLE?

Not a bug. Such a loop has no count, as before the patch.
The verifier walks it one iteration at a time.

>> +		op = latch->op = BPF_JSGE;
>> +		bound_val = (struct scev_value){ .ptr_reg = -1 };
>> +		sign32 = true;
>> +	}
>
> Should counted.jmp32 also be set to latch->jmp32 || latch->zext32 when
> rewriting the latch to BPF_JSGE?

Not a bug. It's a limitation.
A 32-bit counter under a 64-bit jump has a count when the first value is
a constant. With a range there is no count, as before the patch.
false_until is too small there. That's the safe side: no count.

>>  	konst = scev_value_is_const(&initial_val) && scev_value_is_const(&bound_val);
>
> This sets min_header_count to max_header_count even when the original
> bound_val range includes values at or below initial_val that cause the loop
> to exit on the first iteration. It also forces mixed-width latches
> (!latch->zext32 && latch->jmp32) with non-zero upper 32 bits in initial_val
> onto the constant path where they are rejected.
>
> Should konst be evaluated before bound_val is overwritten?

No. Only the log at level 2 reads min_header_count.
The verifier uses max_header_count. It's an upper bound for every bound
in the range.
The mixed-width latch has no count with a constant bound either.
