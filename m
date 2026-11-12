Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794508409;
	b=3JbYm4TzYF2ELaTJxu87rn1MaweTtRik3Rt9ucn48lr3B1kDMZ/V+8Rc+8vN3cu9db+h
	 /y546da+9MeSAjEMp4Ok7qgb6AmSY9rftt92Vo/kS5mlkfi4Bny+/+DgE8w+WIiRBjTom
	 e7GYklPwSv3192R99xRlYSddiKXndXnF391MWuW9eYasab07fgFy1JM6sN5LdanoPxwCp
	 MzMcIifrkMgd0DQ2qYG0vxEy2GSJIIgms6c53YcV5D1j51LGSIuAVgY2RMWL6zFzUmXkK
	 qLZLECz8kBtpgPHMNU7LqezLOg2vB7cImDO07Z9HJrIWfj9IPd4KfrN0+vMHOkBR4kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794508409;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=FmhP9MeZo5Es0js2kSt8GfipastboIXrtB3uKJCSmzY=;
	b=JzEWNF6HFvFj9OKE3VhSJZ0LmGXZ8d1WAkyxrL0FHo0cC7POcK9ZTfF+STxKg/z0CGoq
	 kUEDWQzw8+yxXQSdVwXTexGV980AkXWsqrLMMIPf9sVhPVPiA8jqA7ZhndSr+/xqaYRv2
	 M9hLTJZCfWAuWs7utqV1SzTPKcWHG9s3VTRnLBHoZ41h/3sik5Lqu4t8Yte6nCJ7ri0h+
	 8XufjQ0ruOtOQd8A3K1XBP0UQbqh6nLMb/zNtXl0LxF1nCcbH5i35eR42/SuosAb0SnX4
	 +19PbXP2D/M9eH/9JUlu2NhWC42dAyXXwKTsaxjIRZKv2Bi1l6gU8H88bl+Rs28XKfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WMeS2P1h;
	arc=none smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D23606A89E
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 18:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83D23606A89E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WMeS2P1h
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b5973a4b4cso144914a12.2
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 10:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794508408; x=1795113208; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FmhP9MeZo5Es0js2kSt8GfipastboIXrtB3uKJCSmzY=;
        b=WMeS2P1hZnTnffr1aH08d83wzDWTn8SllmQoVjBf3rwrHkLVXzy1iOzvRfrU1VsPTB
         jU1VKFpGzM5Lm/RctBUlZ6hO7tOIK49ulN95pPVl6Nyzo0QyTEKyd2TOr4cf778mVlJc
         Ta1Bk6/+hlIl5XHqMXSAFLWvJLMXNmWbuf8p9S4oNSbmqU6o82kKZVysyADSS9vW8xyz
         qR7Q//akUvVsLlOBQTQc1WmjXhAIkYdnimPAn9nmGXpL5lZEQfyERPZlzAaZ051xmAuM
         2n1qfLW8Zp5ShIvL8P6Uu4/aOzmeJhvjW2kLcKn/C1ys2wKnCHf9j9p9ed+InWCDbEkq
         Kdsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794508408; x=1795113208;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FmhP9MeZo5Es0js2kSt8GfipastboIXrtB3uKJCSmzY=;
        b=QL03rVtuZqJd4ga2DTtJrNOTJbFjpUsANnnuPg8SB0JUY2Jr4tYU4Q96IqPoxMWDRh
         MrYWoZjbUVIJagV7A7nWgHlMlneLSe8GKHJmWqAGX7HxOkOOwRMcpfzBMe59Oqzd5uCy
         VZTXixyj+8dK98Gx/sM7v8Ey9pfqkzt7lqHCGjEO2ZmInS6C8MEcoE/87qIF3B47xX+u
         gBXTplfl0rlLE0m0ufHDU8cBJhC1vMOUllf/ircUIvpeyIe6GCQDty8PXbGG11ZjIcr8
         xnv9nxj8369kmWXXI1dfO+DnLeSW+iWcqUfvMJg+HmDM9u75r+aWnB/1a1mwC8odEwsc
         bcQg==
X-Forwarded-Encrypted: i=1; AL+hErHNVljkbmpOMP9Sw1oyHto+Z5Lj8qcDbJxj35sYzzwHG6wtPQi8+LoNciTg1R6t13XJqSE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/o+XHExiJPmexXAJb5wz0xYuceVXah4lOot9ABA8bsovsPx772
	BbJERcVQ/pSwOCk2Xyq7YFB8eucl9U8yUBmsJ/w5pcrqeXnrH45UtpZZ
X-Gm-Gg: AYBFou32zbPePRUq8VrkaKY8/BLNw9DmswKXiSw9h+vuiMRZuSnqkCgF8e+SeKYC0zO
	Aln5qqlg9dCaiESzdM2yTr3JykU7nH7p3HhrcDJLzZ5Bro1eeHO+oL76feO8e9/+kbsn28nzZX/
	vBc8f7Q5OVaOCT6y00ysQaPpdVUOFG/pjTM1O8z+7jvFCoD06xdcoWI8hZOAOKviPTzxGYl4lz4
	kTbHLOsLV01sS8ytasP7hp39NyntiK1MOtoP3AtfG6lyn/T2kr03oE5MxbH6vM2DVz4xS3TL2lt
	NS1DtVONBGDMRCbQtBrQibIzKw9PiaxEWtf/0FpBQWba3AI7MUASCwSTomb591Vv+uvOV2Rzrzi
	Ly5vL/UXKiDTKQCoCH2TyF9xSfJF0DKLUD1TiHmb+8/7q+NwkbNwM4ENXlh0JrxJXRIbhgx3bqm
	DmuborZ+x9xnHFasLTgc5ml23a5wCWFf0ZFxqcXZCYQds308CsbttYtSZVltoU1J0EdOEK23LJ6
	QA0hNqJZuL+BR7sBoeVondp/ah2ekd9KZWCvrlmDiKMsvgf4BOonL+cDaxZMK4Cry4ScpgjWijF
	kki6Hx+iDKGgAV9m
X-Received: by 2002:a17:907:6093:b0:c2e:4a61:d436 with SMTP id a640c23a62f3a-c50963856fdmr10734066b.36.1794508407688;
        Thu, 12 Nov 2026 10:33:27 -0800 (PST)
Received: from krava ([173.38.220.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095a5a78csm7085066b.4.2026.11.12.10.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 10:33:27 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 12 Nov 2026 19:33:24 +0100
To: Peter Zijlstra <peterz@infradead.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Alice Ryhl <aliceryhl@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Alan Maguire <almagui@kernel.org>,
	x86@kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 01/13] static_call: Index code text reservation lookups
Message-ID: <avYGdFtNMjSrdc5l@krava>
References: <20261109194916.1089703-1-jolsa@kernel.org>
 <20261109194916.1089703-2-jolsa@kernel.org>
 <20261112082709.GC2668804@noisy.programming.kicks-ass.net>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112082709.GC2668804@noisy.programming.kicks-ass.net>

On Thu, Nov 12, 2026 at 09:27:09AM +0100, Peter Zijlstra wrote:
> On Mon, Nov 09, 2026 at 08:49:04PM +0100, Jiri Olsa wrote:
> > Text reservation checks scan every static call site. Build an address-sorted
> > index for core text sites and use binary search to find the starting point
> > near the requested range.
> > 
> > Module indexing is intentionally unsupported. Module reservation checks
> > continue to use a linear scan, avoiding per-module index allocation and
> > teardown complexity.
> 
> So this changelog leaves me wondering why, and at what cost. Why do I
> want to have this extra array in my kernel and such.

right, I'll include benchmark numbers for each change

jirka
