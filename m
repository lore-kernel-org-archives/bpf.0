Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793153714;
	b=3quGz03xX95Bm1xJxbWScxrd7aD9x2KX0LqPnOWnG4Y5F8r99A0I4Ca4mnL/KRKR64q0
	 l/bOrSyJ+pNX1Cm2wFzCZg/wH1EP9mZP1MTf51gdTPgFlE1WLtpVIyF32Z6yxNtLlSxsI
	 tekCEPB5hAKy/C5r+6ACV8mZOnMgHk0nKIZI9nBdv9hZk1RCSqdO9tEw0PfLkm8GqiNcB
	 AM/FrE9Va8+5uuzKpqFBWr8fUktOlqYdMl9mTdbL2LQDm8HftwdyHs9cL2K/Zd4phLP6b
	 zl8FZj2rGnDhgrll2YGlnCel0bumIXlrprL950nhN8UDsEJOomTdfNm471mqaqhCjNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793153714;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=QEFa3ES2OKY+dQxu3wHCuZVbSvWZ06o3OO4Y2BDdtZQ=;
	b=WJvbpZT+bmjWvFY/mMv5JlJ+JzmE2Bx+ys0HQlnhZ4cMcoFQ/r8FcPE48FiVVqt8gJQX
	 YCGkQU9mDo7F+9jJtKw4kxHHsNGaIiHyp6YkrUNp4WepHJPnSV/9lEwOZDOa+LOgRh57A
	 6Fk/zM5pgkysN8g6bhPDi908ba19Cutj9HBtkz8ABXp9cGixye6lcxe6HZ/kN5HVERMvt
	 RpxFIXrKjkjeUF6dhPIeExs5Prx3Zlqiv22mUePlK05/7w+jwIDHFkKnmP8Loj/6f9yTv
	 UAxUIyLrUoxFdMVjLjsXXIxhSsKJijtFVO1dXZMkAMKv4BoyzjAmYIIBFAaGEVVa/2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IF44ni24;
	arc=none smtp.remote-ip=74.125.225.74
Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com [74.125.225.74])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12690606A31E
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 02:15:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12690606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IF44ni24
Received: by mail-wr2-f10.google.com with SMTP id ffacd0b85a97d-48df160d369so120536f8f.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793153712; x=1793758512; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QEFa3ES2OKY+dQxu3wHCuZVbSvWZ06o3OO4Y2BDdtZQ=;
        b=IF44ni24JIhnnR4b1AceMhw5aApH4QKYV8ElccMVFZfP8D47cHUn4EoQXhEq770e3B
         7tyWf8lR9RAkhErIGaRT1uevv5ke00oPp+ZfWjc3KxFadZozZglH3J+Kit5h7Cg6oB5M
         lab9JZUFZLM/lpkZPJwqTsNJTuisT0Be3w+zxmrjOdywC4jEY0VDCOrfA4MwmrZ53TRr
         FPs1OKPnzO322BW/TwFh9mwx/3Kioux9NHDWwymLbqXOD/m6ZHKAViSBvvqUtSJT75BD
         bss3e88pINaxaKz5mSZf+hAloIwtqyxW2vc445Dtjnw1Za3HawaGdOc7MHtrf66nIcW7
         zjvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793153712; x=1793758512;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QEFa3ES2OKY+dQxu3wHCuZVbSvWZ06o3OO4Y2BDdtZQ=;
        b=2PzQduJBkjCkj4mflROM5K1exhldrRDG9xDdlCdcCDuc+5nRjyGHdvZRAeK+Tn+R69
         b2kW1YuTo5sxsREM3jMwFxub8Tt6SjOaJnljBvNegpMNhHqulgsdpK3wO+ExgrhWjR3L
         wZ43ZyNuSH+KiTiKjwyT5Mtq0ObgcBhC7y2nqXs0bw27LJKgk8frU/i9HT4QvRCaayYN
         wgAk45rwsbu4LmPUEcfI9z/sgHYv7IU8Qn3/j/CVWAHeB3r6pHmO9d3flg4RGA5kvXCZ
         OmcKfDEga0olaxOxhRN9k47IlNY/TyvNEsFnB8T7Y0hjB66gduGoLxCOMlTQ/KWEb1zt
         dUAQ==
X-Gm-Message-State: AFq9FYIJy2fkVZ0IO3HrEVXOy1UyCo3Qiiby6dGL5iQFv9ptPg/QQdCM
	u5hkYrrWOUA3pZ3jRzIunYfdtWvgrSHhnVfjK1RGOvVuyvcovFThLLYmU+APKAtc
X-Gm-Gg: AYBFou0Is2Jhvca228O2dVSvVLMurSNseq9Md7mKq6rEKlktOnjwSO2CuGoZi8msD6J
	AXb+7fhgBgVP4Sa0Plfp7Yoc0C5rTwq0GeL9y4FXjlbtzaSSM2rMJkFyuYP7sMgMmZxYMLcmrdj
	5rI2fFbH1y1bE1QscITMcFYy4WwD/3pPV4zD2ianuGlWBl5ZaC0NcpVnXhpFVpkdIUxLAXRrjVO
	otd6+THef1/PZKBaxkjc63Rm/NjuLFsFi+xNvfRxnkRa+2j7wtFpSf5Ut7dosOqztU16C3dzuRd
	hGDHcGeC0COSQqjPOT9LlX6fMQ0ZlQsg5tPs+WOQTc2KDYoSxSqNiNsWgskWN44khGbSNf5PY8S
	S3lMQ2w+RMNvVjwyOhUQL5Z8Ve7BKutWB49cqGgYQd2whNb+eREd+ibyqekOyIvaAcL3ip/uFCC
	766SmIAiJKMVUjBudknQ8JO6z784ZBM9f1rzV4nJ9Hq1yO7BDKlD5fWddLJc7IbqIgVjnk9dBKd
	1YxULjyF1gqH4GxIJ9W36gUfYsOB39MAsFEzk6gU7YKq1o7HCmk3OmZoNbvmVZLiVv0hV5G1UPl
	CQxelPiG7qiFcrxh6vTexdwhcqrUPfp80uk/48tuTStsLXI7r3mArDK1b05RDj/7MWc0PAuLL3m
	09hJdiJz0mOFUXkq9x/K7uWqcpXG/MWxw7Uwx/NFhwVv72+xz9Pl2QAGCVcU4gd8y2JSKhsyKTG
	JHr/F1GNlQssYK7LQ=
X-Received: by 2002:a05:6000:616:b0:48e:5c60:6a3b with SMTP id ffacd0b85a97d-48e5d5dfd9emr2512645f8f.46.1793153712200;
        Tue, 27 Oct 2026 19:15:12 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc39a8sm26800381f8f.11.2026.10.27.19.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 19:15:11 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next v1 03/11] bpf: Let a callback unwind into the pad of its helper
Date: Wed, 28 Oct 2026 03:15:11 +0100
Message-ID: <20261028021511.1203900-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <sashiko-outbox-187317@kernel.org>
References: <cover.1793147364.git.memxor@gmail.com> <cc848a0c0e4839fe34514b89561884c082650881.1793147364.git.memxor@gmail.com> <sashiko-outbox-187317@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed Oct 28, 2026 at 2:31 AM CET, sashiko-bot wrote:
> [...]
> [Severity: Medium]
> What happens when unwind_goto follows a call to bpf_loop() that gets inlined
> by bpf_optimize_bpf_loop() -> inline_bpf_loop(), but the callback does not
> unwind (!env->subprog_info[subprog].can_unwind)?

The next version turns the unwind_goto after the call of bpf_loop() into
a no-op jump whether or not the inlined loop gets a pad, so it never
follows the last insn of the loop, and the loop gets a pad only when the
verifier saw the pad of the caller: with a loop of no rounds that pad is
dead and goes with the dead code.

> [...]
> [Severity: High]
> Can a callback with a 9..16 byte BTF return type clobber the caller's R2
> argument register when it exits via unwind_exit?

Right. The pad of a helper carries r0 alone, so a callback hands over r0
alone in the next version, whatever its prototype says.

> [...]
> [Severity: Medium]
> Can revisiting the call instruction with state->unwound set trigger
> verifier_bug_if() in do_check()'s precomputed constant register check?

Right. The revisit carries the r0 of the callback, so r0 is no constant
of such an insn: bpf_compute_const_regs() skips it there in the next
version, as liveness has it live there already.

> [...]
