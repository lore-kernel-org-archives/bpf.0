Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794472392;
	b=GdODFl1DtNyToyDjkaOnaIV7OJFVogh3me+HRq/EBtrZjzpT+rlcZAok+VQR7uB3wSi6
	 8ytTOaV3m4rlQ9jM63eJa2eH/9dfSdNmi/wx0oDScdGoEdGzpaTbOulm5aPnc9UJDuy2V
	 hAmWjhDUa+rXAhIn4nLB2t8gW+EvFY1d8JsHYem4Es8xh2/nmzr1WpsepaV7a8fysuJvf
	 PlzWKGtjQGiH+nfw0ZuxlRKV4rMoJzh1Q6chvL8nN1LgJljMWFmmyKYZsrTOkpCF742St
	 4zH4efFrPDQBD35lJwAJNUO45iM9SyTTDLY2IE5vyLaczWuY4dO8nTm44SoVNqTJhiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472392;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=xJTfby1OT67XeoTOt0SCZlMCyfosFlGi750HkurmCNk=;
	b=3p7P53PadrJ6UwFz9I26UsIN00UQ122hbMXi9af4smG/jorYLWgyBIbhsSqvVTUjVNbK
	 UgIcntxnOmIW45jhdHM3ZNfkhM5ymzzJ8LKf8Gk06vNsjojCHgIazntoSjN/vQ5sVYR9T
	 QhpKCtamnnWCcJLWNm3pMs+n0DIY55jxsJKB2Yaz+wecW7w66AS4byBHAVV/zHbPyCR2J
	 fXOKQkYuTiC5LKOf8VCRJ5RR9XtZP8NJFWpZ+ewmpfdWj+9B4pz3QsSAnbNYMozMfWd6a
	 vmO1JSm3sqn8VHgsHZigPrpRzq5Z/5xXKEebu30WgSrSSug6xGRj0jlL1Dv5jMxdv+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=MrXYtzxa;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0550F606B393;
	Thu, 12 Nov 2026 08:33:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0550F606B393
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=MrXYtzxa
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xJTfby1OT67XeoTOt0SCZlMCyfosFlGi750HkurmCNk=; b=MrXYtzxaZhnZSFHtFyN9j0KUix
	xbfAubyMNiD/Woi8m/G9g0yNjVyfd3l3OCgN5g3aYtLPy+5MSnbD2Fl57EzRujT72oa+yHQ7hVe9z
	zHycuDyS42W19BINL3eorPkqXdGv3gvtQmsTWaRT9lLQrQOWw8EoJ9Q9U5GVhs3amRY8+m+LKTVR1
	3XEyf8xu0p/iAcc6Wlq9Es3A9pcgusFSjOuqLKIcNy5sFWcXU8V/8FdCAqwKyxcPZc05WkvUvSKfs
	KR6MSdwyga81ss/4WB9MyQc6Za3mK6kuoXCKl9pb0qPJwf9j5W0YWV1BnwFfySLQjillClYMym/jk
	CKHnabaQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRQF0-0000000A3Qw-2qqY;
	Thu, 12 Nov 2026 08:33:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4DBEB300882; Thu, 12 Nov 2026 09:33:05 +0100 (CET)
Date: Thu, 12 Nov 2026 09:33:05 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Jiri Olsa <jolsa@kernel.org>
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
Subject: Re: [PATCH 02/13] jump_label: Index text reservation lookups
Message-ID: <20261112083305.GD2668804@noisy.programming.kicks-ass.net>
References: <20261109194916.1089703-1-jolsa@kernel.org>
 <20261109194916.1089703-3-jolsa@kernel.org>
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
In-Reply-To: <20261109194916.1089703-3-jolsa@kernel.org>

On Mon, Nov 09, 2026 at 08:49:05PM +0100, Jiri Olsa wrote:
> Text reservation checks scan every jump entry. Build an index sorted by
> code address for core entries and use binary search to find the starting
> point near the requested range. Keep the original table sorted by
> static-key address for updates.
> 
> Module reservation checks continue to use a linear scan, avoiding
> per-module index allocation and teardown complexity.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

This is the *exact* same code as the last patch; seriously? You
couldn't share?
