Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984691A5AC
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 18:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712170744; cv=none; b=WJQWFPS+J3DpT1KMlOjKS1WumdBsxcFxwwLGjRgR9vlFK9OJfEj3BwVIcbGiTwjl1W0bf0EZK2/fEQoeApxvM1VL17yKq/yZ0mMbF3seZKyatSNygxm9P0pcZR7VlzmvLd5QQqA/jDXoHB43p3l06rGhzEpSuTCEZh76EENNTz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712170744; c=relaxed/simple;
	bh=W8vcQ4rr4fbPI/CCdvDoWGusSRHgAYihH+9oE/Urgss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Gq65SS6ohOMP+mCxQHSxXlWGz3MlgW3AuIWNtiokr3OzQgjxHaYYs/djtPhHALwE9qDVk0DLewG9T6jInzSX2A+xr/PcGtlyw1T6ahzmc2/37o60WHv7Tb0o+F4GcdHgjylKOillA5/YMk+QMDSlyTS6A3qujfiB0Z7eLHgM4tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polarsignals.com; spf=pass smtp.mailfrom=polarsignals.com; dkim=pass (2048-bit key) header.d=polarsignals.com header.i=@polarsignals.com header.b=JhoUiuhR; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polarsignals.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=polarsignals.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=polarsignals.com header.i=@polarsignals.com header.b="JhoUiuhR"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-432f05352f4so977431cf.3
        for <bpf@vger.kernel.org>; Wed, 03 Apr 2024 11:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=polarsignals.com; s=google; t=1712170741; x=1712775541; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j8qtDl2R1iLfV/9xEZC4a2sC5uPK9iEhVvW4wgD5V3k=;
        b=JhoUiuhRLxojSgVRXiwgcDBT7Gtq3Cn/HCQEBjGK1Oz42LQrOKPXg7Rcg50tgcvA37
         wqutfhHfzPx9MSQSimEhLKHLQTjURqVSBKMj5vV/yRTNqDTcq4aU6XVOsc/HQYSQXMWA
         zMlfq/lRj9iNZwQGmoFvGWU1xRnB49MbJTwvHfF+4ZCaTxyZWi22Wnfz6y+R1ABxu6vn
         Di/wDE/eq9ZMq7iTFXzmCC2I+xRR35qFDHbCn7imJbe63PxNks8UJaD/fNPu5Ar4aGV8
         +3kH3pcfSi6kW7j06+kQnNU+FuSBCBbQ73GWauLsv2xHsblzYVbdUsegG2cBrFM8k6F6
         5Row==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712170741; x=1712775541;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j8qtDl2R1iLfV/9xEZC4a2sC5uPK9iEhVvW4wgD5V3k=;
        b=jF0AjUfxaJhhZPHWJyx5JJ2JO+ZWjQlRQ+4Uk+3jzgYJWTqiR73ZI7Q9coU+qxuDOT
         63LZhuQt2PEgcza1+U+UtgZaL+HB5ndo/le/TPhUiAZAbyyw7cydbX9E1uJp5TTGQeQS
         +thVOmlkaPBhrYq6f0xVwzR4tUgPkMyBEmU8wf2BySJwQiVsQWGQko2ceC5RuxF/jw2u
         AWLcOLP6zE1hHZVHWWis8uI72Ok79FpD5tXkJXdxjiwwFfSlM9xynlRgfvT1/XRoUIWJ
         aP5xUKMRb5EilYyoIxLceKVGLEg3aBZ3h4xM6N9TtAr6cGuSc/6OhI9eNWBBaAt5N3no
         3UjA==
X-Gm-Message-State: AOJu0Yx3XopBT5O06nWNpVKM4VhpViaLe3H2TSocqJDb+qvpdzweDElk
	ngyfwb+R1pWqbKJCr53ks1u283/xww9s2ADNrvWDgpzifJ6RoW6NBWZ25zE6/FUrvQltCdh2Eb5
	CZec=
X-Google-Smtp-Source: AGHT+IEfeWsVCqPuplH+C50rFHoFic7RW7cd1hWy+RSXho04niJmt67HqFe1+kBGJ9nKkq7TN7ENDw==
X-Received: by 2002:ac8:7d8d:0:b0:431:5fad:ddbd with SMTP id c13-20020ac87d8d000000b004315fadddbdmr294797qtd.29.1712170741407;
        Wed, 03 Apr 2024 11:59:01 -0700 (PDT)
Received: from localhost (pool-173-56-0-190.nycmny.fios.verizon.net. [173.56.0.190])
        by smtp.gmail.com with ESMTPSA id bq20-20020a05622a1c1400b004344cae29absm39960qtb.89.2024.04.03.11.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 11:59:01 -0700 (PDT)
From: "Brennan Vincent" <brennan.vincent@polarsignals.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>
Subject: 10x regression in processed instructions after recent verifier change
Date: Wed, 03 Apr 2024 14:59:00 -0400
Message-ID: <874jci5l3f.fsf@taipei.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hello,

I am working on Parca, a continuous CPU time profiler which works by
doing DWARF-based stack unwinding in an eBPF program. In 6.8 series
kernels, our unwinder can no longer be loaded, as it exceeds the
verifier's limit of 1M instructions processed.

I was eventually able to get it working, so this is not exactly a
support request, but rather a report of an issue that might affect other
people.

The issue is 100% reproducible and bisects to
67420501e8681ae18f9f0ea0a69cd2f432100e70. Hacking the kernel a bit to
increase the instructions processed limit, I found that it successfully
verifies after ~3M instructions, whereas previously it took ~250k, so
more than a 10x regression.

In case it matters, I'm on arm64.

I am not an expert on the internal details of the verifier, but I have a
vague theory on what can be causing this behavior. Our unwinder has a
few places where it needs to do binary search on an array, which look
similar to this:

#define MAX_UNWIND_INFO_BINARY_SEARCH_DEPTH 19
#define MAX_UNWIND_TABLE_SIZE 250 * 1000

static u64 find_offset_for_pc(stack_unwind_table_t *table, u64 pc, u64 left, u64 right) {
    u64 found = BINARY_SEARCH_DEFAULT;

    for (int i = 0; i < MAX_UNWIND_INFO_BINARY_SEARCH_DEPTH; i++) {
        if (left >= right) {
            LOG("\t.done");
            return found;
        }

        u32 mid = (left + right) / 2;

        // Appease the verifier.
        if (mid < 0 || mid >= MAX_UNWIND_TABLE_SIZE) {
            bump_unwind_error_should_never_happen();
            return BINARY_SEARCH_SHOULD_NEVER_HAPPEN;
        }

        if (table->rows[mid].pc <= pc) {
            found = mid;
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    return BINARY_SEARCH_EXHAUSTED_ITERATIONS;
}

(For more examples see
https://github.com/parca-dev/parca-agent/blob/main/bpf/unwinders/native.bpf.c
.)

Note that as I said, I'm not an expert on the verifier, so my theory
could be totally wrong. Please assume I put qualifiers like "I
think...", "I suspect...", etc. in the proper places in what
follows.

The commit in question made the verifier track the bounds of variables
more precisely, which might allow it to verify more programs. This,
however, has a downside which is that it causes an explosion in the
state space. In previous versions of the kernel, we could just verify
this snippet once because the verifier did not precisely track the
bounds of `mid`. In the new version, we have different bounds for `mid`
in the different branches of the main `if` statement, and the set of
different bounds multiplies in size by 2 each time through the loop,
causing this huge explosion.

Now, if I intentionally confuse the verifier and prevent it from knowing
the bounds of `mid`, e.g.:

static u32 __attribute__((optnone)) scramble(u32 val) {
        return val ^ 0xFFFFFFFF;
}

then, in the main binary search loop:

        u32 mid = (left + right) / 2;
        mid = scramble(scramble(mid));

then the program verifies fine, as it did before the commit in question.

I am not sure what, if anything, should be done about this in the kernel,
as it seems there's a fundamental tradeoff between precision of the
verifier and performance in terms of instructions processed.

-- 
Brennan (he/him)
Staff Software Engineer | Polar Signals Inc.
E: brennan.vincent@polarsignals.com
W: umanwizard.com
TZ: America/New_York
