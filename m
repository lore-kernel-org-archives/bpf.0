Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793311151;
	b=f4sYmKjcKZupg0kqbQN6AsvesVis7Jspxdy/h0sU2Zhvm9Qt8lJrnCY1tEj4V5VAZsWN
	 N7K5HEwUdgZknpd8x2Rw9DBbPbRJbgxNsfRAXA7nrFcDbGok5LXehveqwsO4FyfoUXtT4
	 9EmW9G+ZcC+qtKxdGqXbMyMTHTAcFJlrURDZCWtXp9gNBcxpTnFMFyzOzniRiIT8W2daT
	 7jT9HGstBtK5ZhHWmEKMbxbvlZMLUYH9hkxaHGQqiA1Pu0O+r5QZjQW5OYEn0bU44Q1O2
	 yTCkGBWEdLZs3qll6O/jFEbil+NZDW5el69KpMQyIAocRhLCmCdIYNMscaPaACmVC7g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793311151;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=lD4NnHsGQ2Vqml/5riD8yTS62RWO3XbEmugu6s7tsuk=;
	b=aMUFN1Xdqbel58+8IX9F9aPC6CTFm3MlWk+sU7OxUGNAXjcqfVgZgV9WUsE5l+5JNvHk
	 XK5K1IBF5ejeuXHJW/0YPTxEnNsGJgHdwCtltQirITV8wmE0CcIL5La4ytXQKkfWU8GWT
	 qdJQWKM6txp3iELsxo11D0pRSKIG6xAn1jeVyUf9bsCr0uVzOYM48JrzigF3v4HKxzi8+
	 jbELGYKbyEIKFeouiJySJ6TcBq+8JXjE5DF3XI3J9v0Tr59uGe6D1TFPYlc5WTdFsx8Vk
	 Qz/ZvQouFjAPHu0ir3ts7Mhr97IBM3543WHHi/0TTIKR+Br4n8+tdF6jX6dn46/AyBQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CXE++N5d;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44714606A320
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 21:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44714606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CXE++N5d
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a018493d57so25895e9.0
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 14:59:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793311150; cv=none;
        d=google.com; s=arc-20260327;
        b=D1d9Pd0fktUjgWjjMw9ysZZ3/pW2x9OLSsX1rJBw5XHHPiDSRXcp6XeoRoTKV/ziTV
         EWe+DQgKvKcj9h9StnoMw6to5iBf1Oos+gnmiNPmJEJbHpHsY2wskXgMJyQVR/vYEQZN
         VIbnvWY1teyXNrnzEEmK9eBZHAix8Fj+6UQkCkC8aKZ7/VpfsgfE9Z7wc2ahrMMGuFPe
         kRIkVk/RECYK1u8xDa3rsu2RuT9KUfDe5Y8EhWx7JGmumJH0B1wEFrkPyl7egEVOAMkp
         D6rcF0mwdQDbTaq0jtK3mG3BPOyL1ZWOtJNbc4bovPy0tDfMdMNgOcpaV9YYhItQg8jc
         +Sug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lD4NnHsGQ2Vqml/5riD8yTS62RWO3XbEmugu6s7tsuk=;
        fh=VvnEcobxfLecKSZuYA0Qbe4e7XN97OaGRF6vqSkTURY=;
        b=qDCZz/9XsRlqhzgPhtS5EVQuslw29X2OGj8ByUOQA+BCRST/KwKEGVvMd1uqNWQmuJ
         CIUwZVXDUwvEp95UGtvcm0oImUhQdcTn4AVExaMLcEOHaokXEzfY+SqBkuUt5pWhbDdC
         ycjTEzNNyznxxidh8EW0wyXeltnXcXWAJETFzNwMlUVhuCAPfZfcyfjAhcYk/UiaRVS1
         xJc2sKpQjeHZ9V9TB4BudWtM1wYfh2MRLhgMdGsYmydUGmi5QsR2KeQN9qW7KDnoa0mn
         G89Uxt/ePxx2oA3CrlooneQ37GnmGo1PCSPxXzIfdopa8qRIUGD1VtQPlv62TceyzZU8
         8cFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793311150; x=1793915950; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lD4NnHsGQ2Vqml/5riD8yTS62RWO3XbEmugu6s7tsuk=;
        b=CXE++N5dmB5IkjGlxZH28gvFCgXnsc2wrfnP5g6TtCM+sSlbwflisl0R1KLXrUnOKS
         Ek3rbBE5w2zml77efBruyGCAt6HbvlKgxrYbB50rITUBf2xJK27r5d3N63AUEoW7o8Bd
         UXyRMMLOQKImOAV3gkeB/wxDTy2THktDT6MvhfJEeFDtNy5QPzoRlX2efjLsM/dFBXJ8
         /yLJFCaZNVaBzM7KAWLwVt9vg/09he712OjVvnwAFjgkpJLA1qFb31g41pzV+YA2mD9W
         uoFCbzGcga040rzzCpMd6UObaPwww4loMtBHFsY98Titg1RuF7k5rwYfAFKXNx8Q4IgU
         sRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793311150; x=1793915950;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lD4NnHsGQ2Vqml/5riD8yTS62RWO3XbEmugu6s7tsuk=;
        b=qDTES8knfmSrI3/WRJxJt+mJFHwlgdUdc6CCaAy2dVNb/mxrHCL5/okKAzJnF/Dr9G
         u6qSnBaPwR1d7gKjBcbihQNpRRANIVMkPXy1A05LmKfydxqFtZleXJ7oPBWDr3vugFjd
         lu8hXY9auj92FyFj4u97Ui4qWqa7seDR1tVjTiVwd5WyhCsOBbvRj872fpCOzKAzSZjg
         zgdWIYv+N8nO8M8AeAwk8s/iHCc3IS2Gcu6PNn4yH4RAx9FoAo/xXaQSR+Sy4CkgFjNZ
         4YSg63UAvfsgcmzm4kahJZYKsKp+MFi37zmLCpwNAyDD7xlSKn8dOPCam06waBz1Q8bX
         MKjQ==
X-Forwarded-Encrypted: i=1; AKwUvBysHIM/8erc6T5Ov6Bbx4HlaRrp8GV9LWiEw4SjSPqeCRNPotimmzQIyXY8IDYLbt8ASck=@vger.kernel.org
X-Gm-Message-State: AFq9FYJgkNHJVOfCCOF7kChVsrXod6YpTWYEufQlYSU98eh7tyhriJko
	nyvyb/vRMyi2Siq3QIf9ANj1QA1XOQ0PgTDzEG5Gzz66Sqme7yuypfFIO1/wouAjICy0rvyCEPe
	eUyzRN163UxbzdeyKNNBorYLfcYAf0wppAp6qtaCV
X-Gm-Gg: AYBFou2+QX+klm/dFVLT6EtyYWoO14tSoK7oVRB/IL5s6gNx+k+nqtZcizy5MJdm+6/
	V9ITDPZknQPy5Rk7Z43cqKBO/1mGFVje7gx8XfAEC7ZdZoAADinnyIkOy253wfUit40cLe8tgrF
	rkVU93TTnSpXvnvyfV9r98d6ltKjU7VTZOyapqbv0sH0NFA8NCE07Vw0vlNr5Xrfe6EY9jQL/+z
	CyxYpQvAWhKuFLfNXHMTeErpRyWxAq0tHlKfIn0EdKZq3gSlx8x3yPB35D4oyH9l+0dvRrH5EGm
	sfdCf0DSjArxcY+PONrvxXWo9G1tZKEtVRjfx/XtyfkCSe54dkDF7M5wAENtyZaC2flJA5Mt8IG
	CGbnJupUMI3ZA/tetJyGuaD1rJv9me37QEg==
X-Received: by 2002:a05:600c:6098:b0:4a1:e7d5:5132 with SMTP id
 5b1f17b1804b1-4abf6e63ee7mr351585e9.3.1793311149227; Thu, 29 Oct 2026
 14:59:09 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029-b4-arm64-callops-kcfi-v3-0-1b011ad5ddec@linux.dev>
In-Reply-To: <20261029-b4-arm64-callops-kcfi-v3-0-1b011ad5ddec@linux.dev>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 29 Oct 2026 14:58:31 -0700
X-Gm-Features: AclHuK8ASG46JARQbXb1REUMHY0OEjL5EAbmE_577-jrD-4XvLvRMqXYq4UuuIM
Message-ID: <CABCJKufu04HxOurNGyg2uHAeDVyTNQZwBeb4Nw95LL8L1AUFKg@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] arm64: ftrace: support CALL_OPS on kernels built
 with kCFI
To: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Kees Cook <kees@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Puranjay Mohan <puranjay@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Ben Cressey <ben@cressey.dev>, 
	Florent Revest <florent.revest@linux.dev>, Bill Wendling <morbo@google.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jose,

On Thu, Oct 29, 2026 at 9:53=E2=80=AFAM Jose Fernandez (Anthropic)
<jose.fernandez@linux.dev> wrote:
>
> CALL_OPS and kCFI have been mutually exclusive on arm64 since commit
> baaf553d3bc3 ("arm64: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS").
> kCFI checks the type hash at a fixed offset before the entry point, so
> every function needs the same number of prefix NOPs. Before clang 21 the
> compiler could not emit prefix NOPs without also adding the function to
> ftrace's table. Since commit 9315e22b0c0a ("arm64: ftrace: allow
> DIRECT_CALLS without CALL_OPS") a kCFI kernel can attach BPF
> trampolines. A trampoline out of BL range is reached through
> ftrace_caller. That path costs ~10 ns more per call than on a CALL_OPS
> kernel, plus ~4 ns for every extra ftrace_ops registered. Clang 21 takes
> a section name as a third argument of -fpatchable-function-entry [1].
> This series uses it to give every function three prefix NOPs while
> keeping untraced functions out of ftrace's table, and enables CALL_OPS
> under kCFI. The per-call cost drops by ~10 ns and stops growing with the
> number of ftrace_ops registered.

Thanks for implementing this! For the series:

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami
