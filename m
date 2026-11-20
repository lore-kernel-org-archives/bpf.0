Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207349;
	b=OlmVGbruN3zpbL7yR3PCYS8ztvbrzeIov1tIQPvhrLWoXRBZYUIGedzaz6SfD/lUd9rf
	 41juFMeBO07pbC6YSj1ZkoMOj/UbH+UrTHGd63g0VPRveK4P/u/6E4kHMydBg+X53caHX
	 H2nw00IC323BbSXj0vnSaFwY9QEM9O2ejUM77xHahL+WA68kq98A8G3JF7GOfoSQsH7Pr
	 qKTKlHgVJeBwKiIeBpIx3s50K29H/A2EJxO+5sczsKnbG/Q9xnChT/d03dlcY5uAhVQoW
	 4qSW91g2vDj4LUHUbdEymVWCpI8LnfYI8UenKpMWNgpz+GJ/QF3MpTbdXfWCvW8GEGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207349;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding;
	bh=fuwOvDlbaHnKX2tXAoZ6681tGyf7Tt3PYUrrz3DpR3g=;
	b=dMAfxo7/31KRq1FJ0RiGRZaJi2OOeJj4KjbDDjHGCr93Y+dnOUutgQE7hhHtWXfme/Jt
	 0N90HR7/0q1fEjeHgAqJ8T+HxJON4nFI6LQy20yq0eNC6c1CPuW7CtSXi2Yed6vwoCN9k
	 V0y235i/4zgfJskVHaDQ0VW8VJIxNT8lm+sxKyqmCyMq+eIhto8b9F6HALvjNn0R/OW4J
	 UVuSs59fx7gRldW6aKOcZTs5os3PiVnZcqjDUfsXWjB7pCtJnGSDyc7CygiivUfozSIeV
	 uE0YLhe09uhRcnKsCBkSEp+4My2qHjcBXbJjclhr2mlBeflkjJGx/5XXGusm/b7uezA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=kernel.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA127606A6DC
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA127606A6DC
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5364042eecfso17460211cf.2
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:42:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207348; x=1795812148;
        h=content-transfer-encoding:content-type:references:in-reply-to
         :mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fuwOvDlbaHnKX2tXAoZ6681tGyf7Tt3PYUrrz3DpR3g=;
        b=OGdzDHMPBE6NmzU4Ea1oK2QIsEf5CG25ihrvT1WtUczorZe6gBpH9WV/98dUW32d8+
         5XTmFZj6zWzUKy1C8wTAopUYkQk5ItOoydToPSgyhLZLsUEn8W0rqehWaUuZ7mNFOs8H
         rKLkLwbAY2qUiHM4GLHK4jYmMlP1IMU/PVUZAn3kYmsVN6I9s3axHBVa9ugyZOCXizUK
         9qsRxbjtc+CBsRg1jCw0r2NRD/tJPBFZzG5KVTrVS3vkDA0RrsBxwU2qjL/Rh74IrK99
         FGLPnjkzlkxtQF4avhnMrTrQiiC4lXxuD3pncln3vNwqc7aXEBdB3oxqoFwe1T9MZ1LI
         DIjw==
X-Gm-Message-State: APuU4Z8GAZ+x6yE+OFCpvBzFuI4fUfZgllIZjKgS9OlzinGQ2WSGoPCj
	POehnstWJgVD5ExK3B+kjZ19fDJ6I6EMFuSUU+0JJS8zjLsVgJpo4OBDkG+5OQ==
X-Gm-Gg: AYBFou2s0Fgs4M8KRnaTIkm5RykBUb7dMVykXVh7FzcmJPKpz4mxNAV8t2RXkdPPjMn
	6Du54beWPotbAb5fmXCrkEo45MRP8uZhIoLQa32C3YH61e34+RzaOAoRrrZuYF5yHjzxOu+9gjl
	NX3svpcKOqXF/jVB4NTwsQtkf5EPi8E1kD8NSBr7aqAFlB13dMYn1EdFUM9MXmxU82OTAa0ixQN
	5Bl9Cda0DYcMuV4vZHrK/JbQ8VIFGkzxMK7i6GD4yUvA+oNzgT7p/WKlRObkcGRk9iTZ3JEPWng
	5C4/5R1elPQwXhMLIStQy6eBxXWLF4J4kJ4YdopsjK2Zehn2g5dbB1lFgw/80ZQ2YLCZYtkWK3C
	cjs83m9kTJ6GC3aZUTlWMQbxXMz6BT0DP9sHvCbzgpMaCYnmQ6mOcOfSVhqvr11rMEOkD8TmhsG
	P2tefqG+sRa2Y/Qg3KcaqsQwKsp8MThzubXSztJqoKo40lWWeDghydOtkB/rv4FRYAgvcPajWmz
	n2x6IVfMUHDf6MnZbsCRyZiQK73TD/SEbzH8jLghRrnH4z3sHnWrm7r+Xcz6bKLJCdjIL6FJwhI
	V1t1rRL8TV17BBRIQq7frQ1x0R7yMRzT07eaFqfgx5+glTgyxwstp9VxbBU5SCrrLVqWde31IcJ
	6RdtTpefllu/kWYJ7UX62i9XfEKfKF5klQ79ZlZIoWvvHz44AjCxA
X-Received: by 2002:a05:622a:5a1b:b0:55b:8632:6d42 with SMTP id d75a77b69052e-55d769ea681mr75958851cf.23.1795207347888;
        Fri, 20 Nov 2026 12:42:27 -0800 (PST)
Received: from localhost ([199.170.132.196])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7884b5e9sm32990031cf.18.2026.11.20.12.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:42:27 -0800 (PST)
From: Tamir Duberstein <tamird@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf v2 6/8] bpf: user_ringbuf: Handle position wrap
Date: Fri, 20 Nov 2026 17:51:54 -0000
Message-ID: <179519711433.18576.2331241177211314374@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20260619004007.EA5461F000E9@smtp.kernel.org>
References: <20260618-bpf-ringbuf-fixes-v2-0-33fde039ddf3@kernel.org> <20260618-bpf-ringbuf-fixes-v2-6-33fde039ddf3@kernel.org> <20260619004007.EA5461F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> ringbuf_avail_data_sz() uses max() for wrapping counters

Fixed by 3f611e9b820e, now in the base.

> [...]

> 32-bit user-space processes on a 64-bit kernel

That requires a separate shared-counter ABI fix; native-width
subtraction alone does not address it.
