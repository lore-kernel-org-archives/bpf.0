Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793068958;
	b=04R5OwiYFZDMheSdQPsrv8sEPBIF2msaY4Bw1mVkew+49RFemdu8yWmyQ74fWLbtOfFG
	 iPtreQJ/0yNtvpipGPeIY015Ca/SJUmazz64d0/EpgL3uEmuWJFyAnmJQDWTelBkwKUCV
	 tizDGz+cWzy4dmyKzC1jW0tvb4d4a1lZpVOpQbEKjZzOsIhOlKcKZEdZCFh2lHqDtOUCr
	 iyhNz0I79jTNwYZWrJRR3kAG+Y2L9v2tAV8HG7MTFtQqiEQw+iRFun712IN5s03jBavAJ
	 wn9UtDbsrgNjeTdIz3GOBWsJfFUsaeFl8VofT1eUvqlMOoNrptyAYfyCgLCljs19Fuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793068958;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
	b=WlZG04/uArpemJ+UESmsh8+8flmk6CUKA15ppNHEbDbnluQvJdi9cNWI01lYqYhF4NNN
	 tWA4N/ZHyMYbzoTQhfPyzotecE6HVngHLbbpDLkI33iWvoJLt6xBRF3DQk65kXTonkc/i
	 sminWnY3JzxGHniITwLknf0Ul9Nq7TH/o7PoCvWmZ7drsL+3anwsHleh+wIWlsae/i8YZ
	 S7MgY8P2hKsBiXEa5DIvQOmzu57IqP+fiHpza+doMNB6cfDFu4BaEHJGMzRYRt28yd1uL
	 0z13AoXb3y83jIYCc/jMyE4Vttcc48cOfrdS5O5FBNrKWExHSXOvf2dy3+hYrOdutbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=nAMLJ4po;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B67606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 02:42:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49B67606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=nAMLJ4po
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-14fc585291cso1850452c88.1
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 19:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1793068957; x=1793673757; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
        b=nAMLJ4pov/UKnTCLgH305UyFiee1Kbb1n3tCzOl712VaepOkFQaBHOfe8TqG3p1lZU
         FcmqVqrrqUreTloBdzXh9C3S8RzvKdqK0Wdm3ymTtA2e7F8hg+g3tAXi0qMz5tjjKhfg
         XZsmI+gaR0xwl7nmIQiVOSWVXQuFdQ0nDSV/JTrdP8vh+zCmGEp4ByKhGzO7Q9EFAqG7
         Z9UxSRbzl1SyjYddPBfqeotnjUxiWUf5QMQHMI+2cHXwFS8e7Vcd6faApvoLAEI8hyVq
         H9p+0vB8HKXlTDO8gBcIdyEeUOqojMCpKudjjewsxrlbiMp0bSMq+X14CJGfZa/XuOHM
         djkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793068957; x=1793673757;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
        b=bZ/6gIkb8BHbK5v5UsprA+6dROArinsc0Xh2Y8lCrfMnO6acwCdVkM4nGx0rAPqhlk
         XkcTZvQoRPxjcl1RUNPUyS3LNFkrIsb+3VRO3U0XFj2sRSz46HEBlw3CRHaiRTT7xfU/
         hP92QZwfgHX3RQzlgzgwX4AonO9ut9ZceisaRa9FLT2nALrf5DdZ0N2o+p3yQO7IG9D6
         o3xB3vZHVFLE3qG9dVadqFXIbOUu6u7wtoei9FjXDakWdS3AJuE35xsvxGZGR0Nt5+zv
         sumBs8Wes71TDqqs34QXLnWGPWniW32oUS7abDkKuPIJ9ZRs3hmJoJY9kJ6baq83DgTo
         eyug==
X-Forwarded-Encrypted: i=1; AKwUvBzWnFmoa3F87jzBUZtusw7rOb8yuAqBZkk3fvss33kKo08pW0zJooSaSGV8nEKPA7wHqMI=@vger.kernel.org
X-Gm-Message-State: AFq9FYK+uFAAWhvNf5djgzVpokRwSfS9Yfxn1c6w01uVVJQORlcDAJWt
	H6bGHm1YI+FYHhG+o/8Bd4nOqibDYMLiuwrESZ4toea7RNG6p1EsORPP/NiIsAt/rU0=
X-Gm-Gg: AYBFou0vlpXpgsA5nSseU7RbpL6Kvy53FdWx+/DD+eBnWYH26/Hh1wFLnGpghzI1RRe
	OmvIXW/nWUiXTLoTBjGGg0ktddaYuWr9AM12GE20xJVlaywFk+m1Y0RQsM6RDddbd+v+IpAqJ8Q
	cUj4Xz/pEjN1vC9qIW3rBOixk/sw10yfExki41xXcE54+VsrGUMYzW35okEjicnFyxxVoCDurf9
	hUbj2c5UdXwBmeP2F6OSD2nWc+7/N34eZsk2u/3foiMrlDyU/edWABs9pkB+rz1BhX7BbNvnG0V
	aVq3uZyaSEENAwTpB2XocJ3eR9xaVCcJimuc6aZiGVz08tago+qYSLt3PIZQXqnc1DU+N7jGda9
	pCN+aoOYmrmH1dN+1o2P8NnveAmiWo5z0ZFyIJDakRTD3TB/oer2zFDAwK5uWVOyFNY1SOjDrNl
	u0P04bU8BwD9O7Ezl+asQGSdUaec758MqnPVugc3+uTzBoZREu2JJeM0si7nfkfgsaNCkweLlWk
	IJaBxZIUn4TiYY4yWquL+JOeOGcHX2cxUc+3+X5fG2xEswSjyHiLzlv0uOuULc7THRuKwOqSzns
	TUn3CQW/mD4avoMRdsODq/BvCUijrKRbmexPP68=
X-Received: by 2002:a05:701a:ca07:b0:144:fd7c:84fe with SMTP id a92af1059eb24-19937307669mr13761314c88.35.1793068957501;
        Mon, 26 Oct 2026 19:42:37 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a249c331sm59514670c88.17.2026.10.26.19.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 19:42:36 -0700 (PDT)
Message-ID: <30b1cf28-61e6-4f28-8e28-79815bd87617@kernel.dk>
Date: Mon, 26 Oct 2026 20:42:35 -0600
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/10] btrfs: Don't copy encoded read data to user
 memory when canceled
To: James Houghton <jthoughton@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>,
 Pavel Begunkov <asml.silence@gmail.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <mkp@kernel.org>, David Sterba <dsterba@suse.com>,
 Chris Mason <mason@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
 io-uring@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-btrfs@vger.kernel.org, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261026215226.3713941-1-jthoughton@google.com>
 <20261026215226.3713941-3-jthoughton@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20261026215226.3713941-3-jthoughton@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

