Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849EE321457
	for <bpf@vger.kernel.org>; Sat, 23 May 2026 16:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779555225; cv=none; b=TajURkYgW9W8rAlItBKPueMsM91xXRxEDEdDJ6FnkVcgbbjqF5GJXNFgqtqdc2aMgjO7/XQXQwWQIWoPliMCnJDyHv+2zZIvr7ddklv4eDURQt72Dpj3M3Abm3aUb+PmdqBQi/QEB5K4F9WCv3hw6D4PLJg6mojoiSmB8WYCZqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779555225; c=relaxed/simple;
	bh=MtqifYllkoj5l3UV1nR9ImSBD7av3EJIAelE4M0QQmo=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=LEf1OEbg6cs5h7J00itO7KKNX45j7/B2GwbZD9QK5357DsgzcPJwkMPGcWssLyZ3O3TykGKuqQGnOMqeYP4rflsohq0I8YRkKazI0oPHz0mMZZNS3fV5s6UB1RiJLzYx+fLMmtrUiv2RJSzifRZsCSuMam6OXOSs7qi+a9GNgxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=a9/1q2H4; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="a9/1q2H4"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50e63771d91so80561931cf.0
        for <bpf@vger.kernel.org>; Sat, 23 May 2026 09:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1779555223; x=1780160023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ocLvTQonLjBSevx07KXv0YQMai11QYlv30lGksLKoU=;
        b=a9/1q2H4rTtC0ts/DN6DFYNnSvtwGgtoLUmQZezbBbZeb4BRSyGbojOwDzCT8hAU0p
         vPEi2p2UqRUh32lEYSklT7Hx53+vW02RVV8ejb+rUpcqn5LWNdCtZE0tJOF+HxHuXwkd
         boGB0//XjWojkDxIxQY22sW4KxG+j636eoJKC521t4N/YL0HEVIz4dt66Ro1Dd29gicX
         gOX79248IjbPuJmip7qjEs7bXG9I/EkKnYBAB8QS/WA51C1aojsTWitbC7+iDzqbufgI
         m6zQ0sX/MZyKmuA1I/RL9hrtRtO2MRHCSydjbNPwDXum1UC9pwahrnzMdSLSVwHkvG86
         7ImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779555223; x=1780160023;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ocLvTQonLjBSevx07KXv0YQMai11QYlv30lGksLKoU=;
        b=M5lZwo+5E7Flm3erq1NAAgu+c2Zgi1dfsXV+WIAH7O7iwdirmPwGoLyzDy+Ipk+sII
         dpGdDTReIXdxWVBFzRC7kJa7RfQ1MmVBOqagAqj+qQtAvt+8rpQOmrl4KnuU905DE51S
         cJO4/WZ1GNek3bzSHOEPfOQXWHLP//MhesYRz+fDmV9CAUJnISiyGuPIANhbsoEFiTSl
         HESlkZK8ix2AHMslInwAiT5MT8dfOiAnKqAOed6L1U1PCE5N/g6qXcgC/ZmP1PTy7EZa
         K0rjumETwfHlcbRGt0n1Wqatz9j+961H5VDBCecbeoRkHgiTdcX1DGLZjoGUI502aczl
         qdlA==
X-Gm-Message-State: AOJu0Yza37gqKQIarI68cv4ZxLkb3zUy5wn+0RaHJ2VC8hBaC7yCV545
	6rmreRpfCWjFrQgU7LB8szYwyZ9AS6+1jRX7CmPM7Y39iKtTI/YwHi4dDyPYdd9RSQ==
X-Gm-Gg: Acq92OEUSozln8uZZBXMJul/6gl5XJyi+BohrgNyaDWdfgYgJrmjYOkI4kcg89sa4ox
	8rNOgfslTc4sN5TQRyeWSurh5F3iAs6lvVuY0er/y6rXw/Mg4MI2EeITz0GJcJ2ZjObzWfl7z3Q
	Gpn63rl18rWtU6/pv6HSG1j8UFXVkz0PIrlo2uCW4qDphX/FZ+mPOjTmcunOIlLA2vZviRz0kzP
	Io5AphZuoN+fz3hJDKDvICyoihAwInGQkLdMzt7tXNfL+eM4kkg3kGzASFxzmGpRzWDjuB4shNV
	h9ZOM5ynFo9693QJXKrf1QU4Ug/BEuS2tjPP3qpKw0TTU7JQd8gWcsym5KT0DE4+mMrq6lvbMAY
	8tB0wQbI+JcBODQkOE7xulswzn30ZSHEDJ61iTDrc+oqL5LLULoK/vSn1s7OCa5tnjNzyKhEZ9M
	zvNs+by//ABuRCYJZ4JZ9LXF8=
X-Received: by 2002:a05:622a:480f:b0:516:e047:2f2b with SMTP id d75a77b69052e-516e04730edmr66664531cf.58.1779555223507;
        Sat, 23 May 2026 09:53:43 -0700 (PDT)
Received: from [10.234.26.20] ([108.147.98.162])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc81306d70sm49760846d6.35.2026.05.23.09.53.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 May 2026 09:53:42 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>
Date: Sat, 23 May 2026 11:53:42 -0500
Message-ID: <19e55c1c1f0.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <CAADnVQ+WTfgO636GqgxzJ6r=jENpG704kmNAsy-X8=WyjMOV+g@mail.gmail.com>
References: <20260523160025.16363-2-paul@paul-moore.com>
 <CAHC9VhR6RSq1TUgAyvHmaF01h87Cazy=BNJhk654BP8yfeSwng@mail.gmail.com>
 <CAADnVQ+WTfgO636GqgxzJ6r=jENpG704kmNAsy-X8=WyjMOV+g@mail.gmail.com>
User-Agent: AquaMail/1.58.1 (build: 105801620)
Subject: Re: [PATCH] lsm,bpf: fix security_bpf_prog_load() error handling
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On May 23, 2026 11:25:55 AM Alexei Starovoitov 
<alexei.starovoitov@gmail.com> wrote:
> On Sat, May 23, 2026 at 6:06 PM Paul Moore <paul@paul-moore.com> wrote:
>> On Sat, May 23, 2026 at 12:00 PM Paul Moore <paul@paul-moore.com> wrote:
>>>
>>> If security_bpf_prog_load() fails there is no need to call into
>>> security_bpf_prog_free() as the LSM will handle the cleanup of any partial
>>> LSM state before returning to the caller with an error.  Thankfully this
>>> isn't an issue with any of the existing code as the LSMs which currently
>>> provide BPF hook callback implementations don't allocate any internal
>>> state, but this is something we want to fix for potential future users.
>>>
>>> Cc: bpf@vger.kernel.org
>>> Cc: linux-security-module@vger.kernel.org
>>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>>> ---
>>> kernel/bpf/syscall.c | 4 +---
>>> 1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> Alexei, I'm assuming you would prefer to take this via the BPF tree?
>
> Paul, I see that you're intentionally trying to piss me off.
> It's not going to work :)

I promise you that is not the case. I was looking at the sashiko results of 
the latest Hornet patch and it identified this potential issue in the error 
handling code that is an issue independent of Hornet. I posted the quick 
little patch above to fix the issue, and since the diffstat is solely in 
kernel/bpf/syscall.c I figured you would want to merge it via the BPF tree; 
if that is not the case let me know.

--
paul-moore.com



