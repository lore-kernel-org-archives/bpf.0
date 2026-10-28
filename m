Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793153725;
	b=Z3etkm6CAWcsGi9KphtVPpJxoOoYsbZdklkQNsd/MIRHSRntUAmEmEs3/a/Wz4m6H3xw
	 FdYnXNRrfZLTCJx5fn4FbgzBFG2WyiqTrHYTfqTyNvUv9cR418Mn4FAk4yK7eR+hGfSdG
	 3QdLdvugjlJigQfN0vadHrFHSTc4N7tVVQxW6z0g1FQukUYz2+yH6cAFPafZ5Jztdr82F
	 zb1cj2vNG1C74lxAqyo4yqmS9PLodMm0CrGJ15xZ6KSj7XnewkQLOavTP1l5Bw+s7A7rw
	 HHuNEYI3eQo9GC0AkrsCquHxAbDOMEAoqIHU1Ya0PykJ9Kcf9McrGx0ZoOMjtbtBEdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793153725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=TLUhzJZF7coWWpJdBCdY3EY72DxrE36dqBpJbQzQiko=;
	b=LQNBt6DLEsq0lyRURxrY+nyZ3OOvD+2Acy113rE1wXntIXEG3odRWpQo+U4Zfk5J9IcB
	 Y/S/l7tYn51Mhmdjj0yVsPm2+9dWw+RSjzkhUqqfB5g4FRLwGPJ8IPV7UmHwOYsh8b/db
	 fYrWer7q9Y1IWM3zelWizY41RIQZJGLrhynGWtD6fHC15HqrCQ11mowOzaqORPW4aD3za
	 zuouqwPDPzjjz+V7z3qFZxm9U/zLxs6C1n67ov0emmb+ZLop1dNAeuG24adE576DpgSff
	 vl5gslN4KeX/GIwqeQELu96OyK48K8UxmGj28e9YbcrCjhdjeUMwJa14bye1e2ajm1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ToUiZm6i;
	arc=none smtp.remote-ip=74.125.225.74
Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com [74.125.225.74])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3DE606A329
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 02:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC3DE606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ToUiZm6i
Received: by mail-wr2-f10.google.com with SMTP id ffacd0b85a97d-48dee584cffso193246f8f.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793153723; x=1793758523; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TLUhzJZF7coWWpJdBCdY3EY72DxrE36dqBpJbQzQiko=;
        b=ToUiZm6idNAHQEJF5yBZ1uEETRSzz9dNtsL11+5wujXj16w8X7slOmNx8jc+0aHt6q
         377AAeTN70A4YamvDI2DtQ2BFcwXUteK9YL6KKqrmVFPz3usUVChfoQmhO0zxCIjhA/g
         MhAUbzVbNIB3movOGb0CHujYq3KHURqhse5UYCat4IuV5auxsZ5p5m9aDceKJMe8t0HB
         /4cEEwk86toVq/R1nIQNg267qkGQW7W+2f3qRwAX0Jtq0/X71fQPtGa1NcNIBbk9i49x
         ZPIVw3snfb54jT5bCLgM6YPhYNanh8AMc8ggOYI6e5d9MwcfXPefNyJBMHVo0cpYaxZX
         TL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793153723; x=1793758523;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TLUhzJZF7coWWpJdBCdY3EY72DxrE36dqBpJbQzQiko=;
        b=XoGYrFC6C6Nr+wAoaYkTduYKLpfVbi7XkDBg8H4w0dJzd6oFADhD+fqSVUg8IiuNkI
         It+SJzDzH9056v8qhznlZM/DFBM0AOqGU/5zd7yKZNLvVPrtBTXjSe75m3RA+1ShpEMi
         kOOVcfeXbBeeMaZ+C4Jl/0w0SlPmLeFAVs8mS8UuTxneUvgs0HL3yqujf9XiYp4YbDsE
         jij+tWVUEc91uX9EFICVCp9uhK3chqHQSpNPWc/VULuhgy1TWvodJPe2RpG6XGwFWVXO
         CLUAibL/MU0rjZDWgROCky5e4J3bmsuE68X0Sjmkcm+wbrQms10JEhc6mS621cka/Mzo
         Y2qw==
X-Gm-Message-State: AFq9FYKYxRFIEa5Rch0g8kX8QIWD3pCWVtAC0bZdeYR449zmP7haURhd
	ZFF7iNKg2x4XkYzlKwwcoF6yjPi7ZrogFmN+KCllq/vXctngEXi53PX3
X-Gm-Gg: AYBFou1VQ9RDr0PqtMpnrcyrxPFF569QwUsPH4Cx9i6anLmMii2wfaw6A+LlgKUaT0J
	wj7CdgW2gknQYutuXtBCPQIIg+l4dFZY6mSb5LmQ9gr+CAqXJGajQnHI1j13wf8x9MOv0fg28sk
	fbxo6L+wnuhmNlwaEPyErOM3YOQZzefdn9aek1kExyGrcfyO5I/rdxbff+7MG8D52CqYtDH8T2X
	h3OtlmU3QqJu0w1QEqXWQR7d5Bar4Sh4ZBPjshCfkgxfYIZwCdDAk5scnIQBY13JFMqtXigtjul
	W5dWDRAdk6UvS4GkPfBcwlk8IOxqiml035KvKY2qpD2U7Dpx3fEZ+isoerCpLzCqoQyW2lINceH
	ctY1iTn59CR1JRwUigI0rBXUvXCQErLtfmgao4z9b8wzB2g0RLLDbLWTzaPTGR9Cc20evbfOXiO
	PfygSZ/3RGsOqP/n+4y8MmP57NmTz7O+0Tlc4QNawYYzY7xfCsiUC4DpTETYd5ZjJTJpCfoafKM
	17Q972OzNJ0MXP7fMh0H0pkOc/RdZhLfloQSnk1ex8il4TQNB5gwz2yu9JraJdew0M8v6tmKqN4
	c59awzraZC5Cn2TpBmduTrpK0TXXW8DjO7mdERq/XZJAvFhxH7FlFZtr5SY63qMfoQuy8wnNMtI
	htf/xcwPm1vLcxwYlKhyPzNCj8RVNKYtLjykS2kDmnvuRLhAUTQDUZlpHNkwe8KG8az4AXA==
X-Received: by 2002:a5d:630e:0:b0:48e:e98:8b6a with SMTP id ffacd0b85a97d-48e5d288b0bmr2093835f8f.4.1793153723140;
        Tue, 27 Oct 2026 19:15:23 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd48e0sm26172954f8f.38.2026.10.27.19.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 19:15:22 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	kkd@meta.com,
	kernel-team@meta.com,
	martin.lau@kernel.org,
	yonghong.song@linux.dev,
	mason@kernel.org
Subject: Re: [RFC PATCH bpf-next v1 05/11] bpf: Let the callback of bpf_loop unwind
Date: Wed, 28 Oct 2026 03:15:22 +0100
Message-ID: <20261028021521.1203900-10-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <d7e7a55c00b4ea31b7ff71b901c5e2054ce3f0a67d5c39d9820b29ec215c2208@mail.kernel.org>
References: <25728094090d9bf3e4cd88feecec336f0493a5a9.1793147364.git.memxor@gmail.com> <d7e7a55c00b4ea31b7ff71b901c5e2054ce3f0a67d5c39d9820b29ec215c2208@mail.kernel.org>
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

On Wed Oct 28, 2026 at 2:25 AM CET, bot+bpf-ci wrote:
> [...]
> TL;DR: If bpf_loop() is traced (fexit, kretprobe, function_graph),
> bpf_unwind_leave() may not find the BPF return address, so it may WARN and
> resume the program in a state the verifier never checked, possibly leaking
> pointers or references.

Right. Every function with a pad is notrace and no kprobe target in the
next version, as the verifier lets only fentry attach to a subprog that
unwinds, with a test that fexit on bpf_loop() is refused.

> [...]
