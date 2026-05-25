Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6016B382F14
	for <bpf@vger.kernel.org>; Mon, 25 May 2026 15:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779723840; cv=none; b=DpiFJ1vctWqZ8MkLVcZLFznb03JvH0m231P0sEYads4JXOzwAbvnHXxb6apH8cAkamrABTV9CS1Bp3HCaX1ug9gPoRVsHLDsFPtiR3fO9VV0x5sawUPiU9FwDpnYyjvONVzBPzrS8tfn3E+tZz+FaQPjTOUKVQZxQSMY3HE8hmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779723840; c=relaxed/simple;
	bh=aMZRjOFT5FjzGfTu9MbE+34/GXhCUK+r+60ybmg16ps=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XrgE4eeVLXg8LQyAXCsv3cOqDMLtcDHsgmf4DiSQuJo4NOa1MYi37evtmPLry1Mjz2g7SLUyUvlA+egnW3hJIEeWAAXse+5sPsQFDV8q7lkplnUNOHixVCN7IliZhy8P9IQVHsoAiMG9rCpMASNcjkLIgtQZ3YBnjtIrRnRH0Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ujwy4iEu; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ujwy4iEu"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-44a14580111so7305846f8f.0
        for <bpf@vger.kernel.org>; Mon, 25 May 2026 08:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779723838; x=1780328638; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=abZqFBSzztWZdpGscSRSKYjWVyMSes28s0s+iKg65LE=;
        b=Ujwy4iEuwO2vlCKIkU3W53dVfQ1yj7dfkluinrG8Q4RlWivwhwV9/DGyqp/K1hlOPr
         kAEHChStfs0ND4ecW8OkIi7FOJnS1MyBkn21n5NMTbf3P73RlotLJoHHNZ849kT28AvD
         bowelmPsOwqkXpq3DyHQ06vDMbwoevamA6Lbz3i9OjcDZ9K+f+fMJTwFsaiJVzyOq60b
         4UCmGo0Aigl5o5ow7/HQdgUkqAe9cVTU4ai0mt42hzqs1+Wyy57gTwkkj8gMbZusIgez
         5jk254x9BNNlBRJ0NQw2AVc8IpQ6+vOMycVsLE6/PzI/A7RI1W0fSJ8dgDqFdIHGA+NW
         fwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779723838; x=1780328638;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=abZqFBSzztWZdpGscSRSKYjWVyMSes28s0s+iKg65LE=;
        b=bnMTO6deesScicKTrre2Y09Gdf+hjWEX5KJmkpb9hc6ixqOveLlqwcwFe/QcDuwfiJ
         RWCTU+JCtrE6sYEQlR9MD0gs6TVHVshnEWuwxUeARDLilK01OjvANXMXECF43GqrlC9N
         wxefjzmSksYtL08TwtPFRiGEzJdGm8Koek6IhFjkCVNUS0IUUyAQQLGHV6lwiuBJqOcS
         RNn+RyJVPcCmKFKJi2Jdp+1eTYvDIhl59ZBkEcuotksFz6A0udkgMbz6DPbrz+MfPd93
         ycD/JM/T0C0keXN9pBVbAr6Vf25RFG+JrQXu+3iI6I6vuWcMRZzxGSrlZEO4A6k2uVTU
         3jtQ==
X-Gm-Message-State: AOJu0YxaWXHiUJtgcbt+cggJDhoBAAMERkQ9W+A1YbIdIdzmUqNnd4h3
	Ep0O/90Coiddw6rFCmUzamUINCGJDt0tXQNh5LWI1LNs0iRWlF3CQ4D5
X-Gm-Gg: Acq92OFMHzxobcVRA34dMPsJtCBdIclmDnl7nganf0ZjqBVoNG3sR9o84os6vYj3AhQ
	IoXBH/hP6+bP6lbXOQ+YN3thcUiRr4gCeVcj/jaiB07C5kjVo1ABW8BZbOZpukGxMjmh/sZiK9V
	OJal0BCcBckso3txRs1EM7rVZ++Jh8CFe/GTezDEXtBMbcQGclFHMMDUIlAvxUm2Z1He1vjIzEa
	GLsMKQRqDP4P1b3qWzmFO3iKFQwlQSGMVgS/Da6CUpTvYogmR9NsgzaFhboQxOlahg6kgCGFAZ5
	QrVVkYrF9cabjGCbpozjaiv9HIXZ0ZHtAxiflcYC9I+KpuYNi4FS6TExPhK+J/3ihQde5Mh+YZO
	J0OWKTc6CjtBN5lxx2nQTngtI1p0mvnFBEQKYdIjTlHDZmp4ygbXG64oY+AYkJGDwHWgpeDlwEW
	pyBwcI5A//ijo=
X-Received: by 2002:a05:6000:4283:b0:44d:261:54c5 with SMTP id ffacd0b85a97d-45eb38b7934mr24032618f8f.30.1779723837463;
        Mon, 25 May 2026 08:43:57 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d5e484sm27025259f8f.30.2026.05.25.08.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 08:43:57 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 25 May 2026 17:43:55 +0200
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCHv3 07/12] selftests/bpf: Emit nop,nop10 instructions combo
 for x86_64 arch
Message-ID: <ahRuO6X_Kox3tVXH@krava>
References: <20260521124411.31133-8-jolsa@kernel.org>
 <20260521132121.EEB4E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260521132121.EEB4E1F000E9@smtp.kernel.org>

On Thu, May 21, 2026 at 01:21:21PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Changing the USDT_NOP macro to emit a 10-byte NOP breaks libbpf discovery, disables kernel uprobe optimizations, and relies on an architecturally unsafe patching concept.
> --

all the other changes are in other commits, I keep the changes separated
for now, we can squash them later if we think it's good idea

jirka

> 
> commit 963f950434fd00b2b52a00da58d5968fea9d4ebc
> Author: Jiri Olsa <jolsa@kernel.org>
> 
> selftests/bpf: Emit nop,nop10 instructions combo for x86_64 arch
> 
> This commit updates the USDT_NOP macro for x86_64 to emit a 1-byte nop
> followed by a 10-byte nop. This is intended to test new uprobe
> optimization support in the kernel.
> 
> > diff --git a/tools/testing/selftests/bpf/usdt.h b/tools/testing/selftests/bpf/usdt.h
> > --- a/tools/testing/selftests/bpf/usdt.h
> > +++ b/tools/testing/selftests/bpf/usdt.h
> [ ... ]
> > @@ -313,7 +313,7 @@ struct usdt_sema { volatile unsigned short active; };
> >  #if defined(__ia64__) || defined(__s390__) || defined(__s390x__)
> >  #define USDT_NOP			nop 0
> >  #elif defined(__x86_64__)
> > -#define USDT_NOP                       .byte 0x90, 0x0f, 0x1f, 0x44, 0x00, 0x0 /* nop, nop5 */
> > +#define USDT_NOP                       .byte 0x90, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 /* nop, nop10 */
> 
> [Severity: Medium]
> Does this change to a 10-byte nop break the libbpf discovery logic?
> 
> Looking at has_nop_combo() in tools/lib/bpf/usdt.c, it seems to
> explicitly check for the 6-byte sequence (0x90, 0x0f, 0x1f, 0x44, 0x00, 0x00).
> 
> If has_nop_combo() returns false, the target IP won't advance to the
> multi-byte nop, leaving the probe at the 1-byte instruction.
> 
> Since the kernel's can_optimize() in arch/x86/kernel/uprobes.c requires
> an instruction length of 5, does this cause the selftest to silently
> degrade to the slower int3 breakpoint path rather than testing the
> intended optimization?
> 
> Additionally, is it safe to replace a 10-byte nop with a 5-byte call on
> x86_64?
> 
> The 5-byte call pushes IP + 5 to the stack. When the uprobe trampoline
> returns, execution would resume at IP + 5, which lands exactly in the
> middle of the 10-byte nop sequence.
> 
> Could those remaining 5 bytes (0x00, 0x00, 0x00, 0x00, 0x00) be
> incorrectly decoded, leading to unexpected behavior like memory
> corruption or application crashes?
> 
> Would using two consecutive 5-byte nops instead of a single 10-byte
> nop safely provide the padding needed for a 5-byte patch?
> 
> >  #else
> >  #define USDT_NOP			nop
> >  #endif
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260521124411.31133-8-jolsa@kernel.org?part=1
