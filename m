Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794394154;
	b=lK4uTJ6TChu6Zra89Gr/sy+aohs8XybNWXWSOm3Vf6pKtO8yJcxa5bqPqwp/XIHMQHFd
	 SKriift9t4hCF8j8jlPSIt6hNMWOzn+f+wGq+JSnCwJcK6JHDgI8LGJePhVPLehy4O31y
	 kKxk803SNPWmOfUJU600XkA2dgUYVzfMl2wXEx6vPhrttettXRvDJn+gvH8fiJaFIZcTX
	 p4GixeRJdMCcTCDhuNCdQsK08VSvC+3bp+SYm2UT8WxoziK3aL+4hh1Wx5BrNKMTYcMRf
	 irD3tXxqg2w+GfAEbq1fh5Skjao11s4/sVWSZ3d2Z1to5fzP/3O7cVAOGzOewsjB5Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794394154;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=fkkdgBcWl/gXMWZL41R2xtfz4IY0JzduuuEbE0bKcow=;
	b=Koh19Aye8OuiXLogyFV7G3SBxyIEXi0mekGlxMRdjT+0lFxv2Wmo8jTjhqLsDw9MT0Jr
	 5RR9lC7Pv7YO6TrgWBM20mlTcT5FdunuM1/H0/PNivnqFxdVVhr5iCYG8iwqDsXYvT0NO
	 MvMsQbYBxXJRPKG/XxsUgNf2r7nHpNL7KfTem9son3QBAH1ZPzxWOh5btCx8vNE6Qk9pH
	 AjcJmx+pBmTB1RFF1U3JX9e0+zYyDQOvV6yO23RBrB7DCenYB1NmdYQmTLm/rMhrSYIRs
	 NSX2GTKPmyiMcAwEoS8fpSKhyBFILUSWauc0eZNS6XRAo6n1LVJQyS+l0tOrzHvzqGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oooZo4JY;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C0E606A89C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 10:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84C0E606A89C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oooZo4JY
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso26205855e9.3
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 02:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794394153; x=1794998953; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fkkdgBcWl/gXMWZL41R2xtfz4IY0JzduuuEbE0bKcow=;
        b=oooZo4JYlJ2CA1rNGsEhbm/Vh1zARDhdjXBHBkBQFL9enJyj+XofgSJLMeZ9+GKxbo
         xok/3WGW+7zKaDcdDmW6AmGqsymXOQ6yiG/TEMbbbrEyTpuEH96hQdA2JsfLDtw41Eyr
         Sq2XWmm/XXn4bmWMceYyGu6JBYckHG8RS4VEVfx00q48LCt7osTBKv7fub58aMqyjRoZ
         nslXmn7Y+YxO6NwpCpCXO3PtFaKh9qhBufe4ceuiQ2H30+4TNUaM/4xKC0tBs6QDF1P7
         vrmAAtrDs3bzYwahjECqPBoax5ttmw1jsuUmag3V4MtFo5Y25+V2ukVgT+hGMBD5uaJB
         CsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794394153; x=1794998953;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fkkdgBcWl/gXMWZL41R2xtfz4IY0JzduuuEbE0bKcow=;
        b=rAUkRf04BvO+XWh4vkBwq1zdHfdTOFcKtmovqjiz1TwXy0Dj6GRw3z/rde9ax286Bl
         ku3PGBrRCaWn2LD1QAphlH3HMv5EaDI8FIRm4wm2Kg0rNrHp7unAHTrTz2tY4STQsLtc
         kApVvDbSZjP/rgpmmhz8PeyqmSf7At5rDiYmzM93bJ7dU5d35Sh3IQFDQYMm5bIaa/YG
         tZu5sO6CRPom4apw3vgBYGR5jC4q/7ZqDswQ/UgUYAXQRxQsFRuxvKsnFB+Ap38o/0kX
         oXlHjnbRM5UtYZC15LKDesEX32EMLSk/Qt9BYceeFApdLRRKB/INeyPNfV5QEkBDx9td
         731Q==
X-Forwarded-Encrypted: i=1; AL+hErEKthICiVdwYddxyxEfp7lvSOmTeooFVkwn/0OIzf2Kn4nDoQnpWwmjqscYrVtSuw1aLoE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8NLba2Kok4QmVhGFQ+U0YMDjjoe+EZMvT2toQEHSMOtexR4aDl
	B3NhosRMuzd9VE6ToPXy708X6ZvVIC5ZXUuP+GOdlumW1tWDScvZsw8E
X-Gm-Gg: AYBFou1nEPLrnRXc/lsY6LQ73DhMP5i6a9nPeMGtOlugZwtqM2mh4mRvxGaNvmvUELU
	PV7kyNm7cdLZzumDsXKTblgGsjsc/PTjxRCo3uj1opePvBfy45XenJiX7IvvpxwkoqEJ/RZWZDb
	G4hbpY3l0vzsr5Z2jj9heO0zTQxhhdmWHdqkRBgUr1J8RRBWfm8eBc/P57xpYwF5RPjyLbF333r
	jTcxDfaHemKlQdA7x5l6fzfV1P10lU+rOZOGTBbF7qJWEhkt/qjkgb9WTgnsAeksFU0AN5sp0gk
	zUSdb8J1DDFuMnxMnX81KIMjGc+7LMWnCnzcfi+/XcIg/e8ldgg+xoc+UOrUmRypE4MDnio61sQ
	FNgeVuYATA1uTA+AN9p/KdZFEutvvmgt09WewblUe6Bv85MfCHKIR+JUuh7XuMr/EgbN6cA013D
	Fd+AGEWakuq3Lr5cFqwV59fN31vrgKqFxOwGy0PN1Ccr1ZK9rXllDbnpyqnVxyy1Twgpd1FLGCg
	+zDCTDP7XCOn9LuHzoLpYLLbDfpUvCkVoMkpYzErp5gBXBLIWN0ePErMqzJr/foG3t9mknfGmsm
	c+o=
X-Received: by 2002:a05:600c:19d0:b0:4ac:aae6:6401 with SMTP id 5b1f17b1804b1-4ba09375031mr37014455e9.12.1794394152548;
        Wed, 11 Nov 2026 02:49:12 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::25dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49835d2c05dsm10153242f8f.25.2026.11.11.02.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 02:49:12 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 11 Nov 2026 11:49:10 +0100
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Naveen N Rao <naveen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Alice Ryhl <aliceryhl@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Alan Maguire <almagui@kernel.org>,
	x86@kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 04/13] kprobes: Maintain an rbtree of registered probes
Message-ID: <avRIJuSolFTwT_Tk@krava>
References: <20261109194916.1089703-1-jolsa@kernel.org>
 <20261109195517.1090787-1-jolsa@kernel.org>
 <undine-1794298339502831052-1b6960b8f9b38e7d@undined.local>
 <avLz8k0gdZwYTeA5@krava>
 <undine-1794325083765212173-9c2dd2a4d5c010fe@undined.local>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <undine-1794325083765212173-9c2dd2a4d5c010fe@undined.local>

On Wed, Nov 11, 2026 at 12:38:03AM +0900, Masami Hiramatsu (Google) wrote:
> On Tue, 10 Nov 2026 11:37:38 +0100, Jiri Olsa <olsajiri@gmail.com> wrote:
> > On Tue, Nov 10, 2026 at 08:12:19AM +0000, Masami Hiramatsu (Google) wrote:
> > > On Mon,  9 Nov 2026 20:55:17 +0100, Jiri Olsa <jolsa@kernel.org> wrote:
> > > > Add an address-ordered rbtree for registered probes. Keep it synchronized
> > > > with the hash table when probes are added, removed, or replaced by
> > > > aggregator probes.
> > > 
> > > Could you tell me why don't you use hlist (get_kprobe) instead?
> > > I would NOT like 2 different lists which is basically doing the
> > > same thing.
> > 
> > The speedup comes from finding the first relevant kprobe, then iterating
> > over the remaining probes in address order. The hash table supports
> > exact-address lookups, but it doesn’t provide that ordering.
> > 
> > I agree that maintaining both indexes is less convenient. What do you think
> > about centralizing their updates as in the change below? untested
> 
> If you can replace the hash table with other faster design, it is OK to me.
> But I would like to avoid this simple-adding another lookup table for the
> rare usage case (because of the maintenance cost, and duplicating a list
> makes it difficult to handle cases where discrepancies arise between the
> two lists.)
> 
> Can you change the size of the hashtable and measure how the performance
> is changed? I need more options.

yep, I'll check on that

jirka
