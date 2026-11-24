Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795491498;
	b=EnDJ7hfSGXiUw0PQq0S8EB6Lz0jnoxWFtSmiP6EOOQs841kjGhW7xEMzDyL4XCQbG6Cg
	 cfAm/gLz+K1fH/JP9R9akDONKp2FXBuC+40yxwKRc9Vq1mo7CE5W20B20SckDXI3FcLuI
	 QfM++tdI/Q9fQbF/pwUSiNOebVrCTq1RND8ZEjv3GzkFnvJGoxzNvmVW3fYhlpvIeq7JB
	 sNb95VD995nTh2FroHx9tieORfqOgVw5j+e12Vc4x+no2Y4UOtj7atfIBAVIUbh5XQ4rv
	 goAvuCvkx8n2xgcEDIlO3JKwVd7DxQfgF3wDiOOWQvet+vmiRx7CXc3wXDi+2dJ2F4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795491498;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=23WFpbkk9+U88u4Kg5/nJhlO5TeXk427D7xW5ikMlQs=;
	b=YRYSwWKU1cc911qJHcoVbsvxTJzT5QRsbBZAxvbB4M0CrAoulnLFRbY8qJEDQjXoF/O4
	 UhfTDMzR0RuehgYom3KYZ9WfTHQtywuM1AXdym+xpTseHz37J9R7mf7SDq69phkxzJVZ8
	 250gIjVYnOwF6bzdBCiaOjEGN7HpEp/Y0ZYH+QWatEUkXabzw8pX9YlWspk+oFVU2GtVt
	 fQHa9R/ECYFadnsEe66q9eqsCNoD921NMTFOQte6cz9lJPascddU5F/wXwwgN4XCm7nHw
	 RSih+NWtllu5VnAyOmDD86l/psXvmb5WOe5VMAU++9nNAvh3jB3MGlpoB2eyFViCd3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ku5aLrvP;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3D1606A322
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 03:38:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF3D1606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ku5aLrvP
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3b487f44ee0so1049156a91.0
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 19:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795491497; x=1796096297; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=23WFpbkk9+U88u4Kg5/nJhlO5TeXk427D7xW5ikMlQs=;
        b=Ku5aLrvP9phrP9bXjiBFMawcdxtMoArwVagFmynW5E4mJSWbBEnhdZXn54Kiard5Mu
         VNZQZgUUtN30jCOBppPq56jGX2vK520+FokqWXFIy8/8RySf6ftZ33UNQfuSfIQ3BfFJ
         TYh+RoASYZq5APEodgI5gH3sv1Mv0gic9KQ8GMSDjuUJQEcv+JNRWtx7FP6R+ZOJ96sG
         QB/5rwMVBpxLLexg4oczTrH/Bj7YuM4sPO2Hxf5fdNA6ftkwFwF85ACievajeGcMABbf
         7jgRs2QnGWZGot/++6ChC+6CZ6iidKQjqhQUeFzzi9+2Yu/3PZ1Sjhc54CDyFu1SP/SA
         yq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795491497; x=1796096297;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=23WFpbkk9+U88u4Kg5/nJhlO5TeXk427D7xW5ikMlQs=;
        b=xUeV9hq+sVfWY+hehHtKwbD+q0qIWZzzFcHKj31BPvUZKVFStYU7tOS3ytlPtqEdko
         qF75AGGDey1NsZ2eNwmQ9DeRR4i1YWjG6bds74nv1IrUg3HH4GzdKpIz5P+lhHYn2Sm2
         IASNR5OGwmKfy0cjC56fF1tF/6kiYIuor7HD9qJgyLDBPDKNe2cQKr8HxOdtCmGHi4/T
         q5Fh4CSHP/YQBng3qgPafmaMWDNv0Fru1PwR30YjqgDMsgubV3lK7+N7vIvE1SwOxEwn
         RzhkDiTXNmgwfX/utQffd0RER31SA46721t/0AIdftXMH7suA23oVAGBQ0V5uBAjZLFG
         azcQ==
X-Forwarded-Encrypted: i=1; AL+hErFxht9TaFWWxJ+1wiIlYi7wguFel56LMuPRgZwAQv6Ru46UIVB6v1jXzGZKb4v1pJGnSuA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+JwlUBxoY4kw6D5xT4wYxKz0wTsJBVNQQSimodY1re6nHfNUWx
	nbM2BHMngsMraCFyuIOCaZWjGrl3deDn88VnwipXjDVTvF8XBSURYr1s
X-Gm-Gg: AZFdTZd6aLjJpCI/LdYHuyALbKgzhwkn3tnBtuwrTV9MUuw+jJnOxbRhv1gt9IykZ84
	aFe/P2D+mmPV6r7H/991DC2fA1hBdi5OK64QFdkFBLhURpR46g2G0Lp0hyUM1bPTxKXfQM5huxy
	bNSbE5bjl048tnbG1r4gelQzgM5Nw8CYSYUf/s3ZidgyrenQrcSNyP/4VEkf243b3sEbJgR/qWq
	vN3UOgvEz2kvT3IkG/ROQeXd0YQ91kE2nwDAl0VkVidYtHQROTgLec3f4oQ7JmTfjeLzkUlqMLI
	C85Ncq0pVoK7ixubNWvLtQfbkLjOq+qpEQBZl1koovR5Kagnaqgzx0w+7VLx4sCHy+xKhir/KlS
	h7wCv1mk2MuyYtgS8XfBGVqvxPFQAG5flRm7nGkFnlGHyzJhKoQArweiy2ytPLLLBRKslHZA6U5
	DO4c3NecW/59piMTIrQphCnxrCzvBNUvz/xUWHDrDproNKRJl+EvbXDQ2viyFgj/UP0G1bocoll
	jy3Qt0Iq16Zy2vmhGjSZpyIkHdKwK6nsHT8mUPiLzf3UftVrMfDU+5gWShoTTk2xwQ4XnP1YAcX
	Ouq7mxlwVUcYaWGwNr0pJMMDJa0zuIqXcWr7KlXi97YiGHS041GEvtFm+Yo0AB9GgWocR7MG4XN
	v5H21M8mBxKbhQVSyYnrcJU4XTHlI18TPXik=
X-Received: by 2002:a17:90b:442d:b0:3b3:fc9e:561f with SMTP id 98e67ed59e1d1-3b41c852ce6mr13016956a91.8.1795491497124;
        Mon, 23 Nov 2026 19:38:17 -0800 (PST)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b48b41928esm10165247a91.9.2026.11.23.19.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 19:38:16 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 03:38:16 +0000
Message-Id: <DN34M6EHQVZC.3ON9G7JB6VVGQ@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <song@kernel.org>, <jolsa@kernel.org>,
 <rostedt@goodmis.org>, <mhiramat@kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf: reject override_return programs on
 uprobe_multi links
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Sechang Lim" <rhkrqnwk98@gmail.com>, <bpf@vger.kernel.org>
In-Reply-To: <20261119164152.3678373-1-rhkrqnwk98@gmail.com>
References: <20261119164152.3678373-1-rhkrqnwk98@gmail.com>
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

On Thu, Nov 19, 2026 at 08:41 AM Sechang Lim <rhkrqnwk98@gmail.com> wrote:
> bpf_override_return() changes pt_regs->ip to the kernel's
> just_return_func for kprobe error injection. Perf uprobes reject
> programs using this helper, but uprobe_multi links accept them even
> though their pt_regs belong to a user task. When the probe runs, the
> task returns to user mode with a kernel address as its instruction
> pointer, faults, and exposes that address in its signal frame.

That's not a bug. The prog needs CAP_BPF + CAP_PERFMON.

pw-bot: cr
