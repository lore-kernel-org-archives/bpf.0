Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78175399004
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 02:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790045630; cv=none; b=oULU1cmMfClrpQU2wSoV7AicW33NGFkHbufxM7J3Ugb23dQxLKgkX+dwfBfmVLn0prXWD9jvXPfHULB0D+1Z0/xWZp3ek2YnV0MPuGVRE1fQXKhJTQtcFjzW/3h7IsI0AnZxH3/uQtQ8DLjtOES2lw0P7QLacu3Lpu9n2O/KZhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790045630; c=relaxed/simple;
	bh=D6FjnGUFqSH40VtbextCoCSGWM2PCQTatVfeoTll1dI=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=D+JpZS0Nz+LvLOqcMJx2TQSFb2TURzfaG6kuJLw7MUXNSdjQXuJOW7SJoQbRpe0OVkII1GnSJ/OsH54J0wONjgaYO92G1r/u1f0Gj01gJTU2YaN7jLLAMXjPnHWXTC7PoI7WLWN0HdhFTlOrYXtqOGuSGjTE5yK5QPK5Swtm3+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ku/mT5v1; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ku/mT5v1"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cebcb8d7so1141190a12.0
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 19:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790045629; x=1790650429; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wM6/yW5gI/hDw4+S5ggd70K1fst5xUknVJJO18BGc/k=;
        b=Ku/mT5v1iORKljl8vjjREDi67SLG4naItBuHWRpVIUTAFNU3BQ7LFIOs0v7yGqDE3M
         0xSJoLxX0MDvxFMDJ9u6jm0nyuR3E/goyOAv8CQhRX/53CvvTbFWmAqnSD1JPvrAezp9
         rMErIabTLA7E4lFak+Gw4Rq1htGaORcpx05QJdTlEOZs83jDeu1TkrpGtF3z5rCu+rOg
         SHpheDQ9HklJ8hPmh2yCEHqocHsmFqoCPRDgww3cIBLpq3A8su6pCrBRMhJd1aBy46E+
         LFfPWEm/mpN6LDI9fP8L0LPwchSuhH/1cqhIUdoS66WePXNoKksrXZkybbhBmm6Pd66E
         s3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790045629; x=1790650429;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wM6/yW5gI/hDw4+S5ggd70K1fst5xUknVJJO18BGc/k=;
        b=hpnOkTufSvw/r1U0dYzm/P5Nt/CKaXlkjbxC15LRIGFiPtbXHvHAKTGnziNLHNSoa7
         pUbJSboNQ4Mg8yJ3QVbbCSE9LFAW2Bv56kc23x6tM5qHT2aAt2XLnTYg11ymoTsqxmD0
         8x+umPKCiER2IkTKMJjAI+FxFoGyKoPXLWYQA6hOPmpRM1RjCYm6fxK0GoJi3OrvkLas
         ItGwfv/McFZpGbGFc3ULVKa72ivaWT4SZhajwWO9x1EsXy/DuN4VQ9Midqo4nW6apBYw
         v6dFKLMhlnSwfIlOs3A8ESLK6hbGEW7KyLvYvzG3/4g3YT2/qAScs8AjUmS93BezFzWR
         4rAg==
X-Gm-Message-State: AFuF++lv3opeIzsPxlbBy1+Mu68LuuQZwq7zYUHDuer+WQYAXatbyCGV
	rGu8U6/yR7B4ZncZ9/11M7hvQbwXR9BJSW6mRcPCzxg9Wy/KNvaRKwbmWP3xNw==
X-Gm-Gg: AYBFou1jArIfRciO/33RK1AgUalW494CKSQLlF66dIPuuWDmHdQcvlYp+oKiKxXTAdL
	TcgIKvudEKAuvB6Ye7rcJvPVcTjQdrXAKGxOEWTlOEuE1/lY8BGD41LT0wY0AbpBAH46DAI6jlo
	4FCC/S2xIYPA4ER0uG8dZe6IznqU/f65cTbGm9iKvlDbvqbBH0b+FrU6WrDYnd0D03OkdeyLzH6
	RY0bsZqSAl8OEQmbfNwLF4eOA7kQ8J2nXGr908I09zh7y4Z2tpFfTaqYpHhw/iiPRBa9d2goB/+
	9Ig0OPMuSu4IMimdVdJiGR/bQr560QmKXdDOZ0oqS+ROueE+VmpECWZHvqUUC1SjvLim8V+N+VT
	1yZPJbibkpUlUeC7vMtpOn0rC25e5IZmZaiLj375YrD0qSx96sPwK9z2xYvVuAjZcdTNwSQ7Mjq
	nbtZjKaeTCn2YiHT+xJQl9D1lXMMmzd9NmaqU5p6mpDI07JngmMZXiHBRFLBThiusTM8/QQbtiq
	cihBRS3h4pBiAh5AErQNRu2NHGsia9bha39ZoGOKg5AWoARwEQZb/PrnQpCEa3l9HTXLTHvx/9m
	yxeZZ048mFidxA==
X-Received: by 2002:a17:90b:3c85:b0:39e:6c68:fd91 with SMTP id 98e67ed59e1d1-3a066b93b39mr1034411a91.38.1790045628556;
        Mon, 21 Sep 2026 19:53:48 -0700 (PDT)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06e26e6a2sm583523a91.2.2026.09.21.19.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 19:53:48 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Sep 2026 02:53:47 +0000
Message-Id: <DLLI7SYQ437V.386IAVGI0TTLZ@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 07/17] bpf, x86: Add JIT support for callx
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <sashiko-reviews@lists.linux.dev>
In-Reply-To: <20260922012712.6B21C1F00893@smtp.kernel.org>
References: <20260922011323.1298619-1-alexei.starovoitov@gmail.com> <20260922011323.1298619-8-alexei.starovoitov@gmail.com> <20260922012712.6B21C1F00893@smtp.kernel.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, Sep 22, 2026 at 01:27 AM sashiko-bot@kernel.org <sashiko-bot@kernel.org> wrote:
>> +	} else {
>> +		__emit_indirect_call(&prog, reg, ereg);
>
> [Severity: High]
> Does emit_indirect_call() emit raw indirect branches without KCFI hash
> validation?
>
> If KCFI is active, it seems __emit_indirect_call() emits a bare indirect
> branch instruction without the preceding caller-side hash check.
>
> If an attacker were able to overwrite a spilled subprogram pointer, could they
> trigger this execution path to jump to an arbitrary kernel address and bypass
> KCFI protections?

Not a bug. The kCFI hash check is what the compiler emits in front of
indirect calls in C code. JIT emits the callee side only, see
emit_kcfi(), so that C callers of bpf_func and of callbacks pass their
check. None of the indirect branches emitted by JIT check the hash:
tail call, gotox, trampoline. callx is no different. The target is
PTR_TO_FUNC with zero offset. The verifier guarantees that it's the
entry of a static subprog of this prog.
Whoever can overwrite a spilled pointer on bpf stack can overwrite
the return address next to it.

[...]
>> +	return cfi_mode != CFI_FINEIBT;
>
> [Severity: High]
> Can bpf_jit_supports_callx() incorrectly allow indirect calls to be compiled
> when KCFI is enabled?

No. Same as above. With CFI_KCFI bpf_func points to ENDBR after the
hash, so 'call *reg' into it works. With FineIBT that ENDBR is
poisoned and the call would fault. That's the only reason FineIBT is
excluded.
