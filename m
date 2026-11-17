Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794913576;
	b=DsnYtlcA/I2WIuXkcqIiQKNgz2VL/dHQJBVhYvoPApr7eeqOQiWr2KHOF0UtepQHtQfS
	 jXwYoJCUYZeezYxTn5nVWK+SnnPcaR+FnJ0yE9xb8MMgu7RrtcLCt4/QqY/1gU/MekECB
	 Gm9CKmwbWWr16JnSXOOlgsE9SLfEqIKFWiOS2tIKDzIGmX8iL+g95dTflu9qIstt697cr
	 aT/+XiYS1gK9Eq04lWvpO8VAA6ukZyGUMMxDhwLmhj9EE3NuAnLpojr3fPp6MJiCOTiGP
	 OIU5UbfHQVa6uwX/SvhcqUyr/gRNQ1A2fYKZNx1/pwIzAuuJ306+71gpSWnrImwSFIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794913576;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ChkKaHHAKUklGidpwJFPREnCjwZb6wuXyqrdGtCbZ5c=;
	b=IXvMRWnrGHBujdWlzexiC1UQoOAGvnOhTcQN5ZUaIKbQmFNMXVll4fIGvH7jihxKP8ZM
	 KK4kA732z6XDLxJV8O4vj8EhYJoL2SgcpzE2r+GMXamARjhSsei9NVP74AQQf1KV86ZK1
	 gLdIIPiSoIbMXw5yaukFL0P8R0C3G2KqTgrrbDFZjtntxLAJIcDR6AfqQ2VqcxPfUHV5A
	 Rbz+tuJBC8Lw67gttE2aubtHiLY/iXwsspdgyq7CEVXY9W3LksWeyjy2BsyrfE6y70HNC
	 vuOFVmgSK35hsS1MIYJoXkrEYvIlHSdHriKRFZAlttvhBYcP4E/N1qsC4g+uIReewsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JVjQKwXi;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939DF606A31C
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 11:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 939DF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JVjQKwXi
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-490f38e9688so623421f8f.0
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 03:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794913574; x=1795518374; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ChkKaHHAKUklGidpwJFPREnCjwZb6wuXyqrdGtCbZ5c=;
        b=JVjQKwXiRy8XPxYTeUjq7l5tiyCjUt7YGOzTla9jHdUnMrkmhfCR4t7M2If0v8s945
         F9TXMBxpxt5QZgL6sJnghTgjBGn36kT80CXs9R9oaOrzqUvLsXYxqtHOr+y9K3nLAWwS
         j7CqR8FWHBqZDqxP1NFGm2EzjQBBNa3Bc0ZcBZ2+nirtHhEecVH4Zzno8qwhjZ/z7QAx
         ccIgxn3UFeEcrAdEYU+P7EodkaE7fBA2tJItJ0phlUztTqYfNe0cFdyCdwt2PRhCraEL
         aR4RegYCM9nfTwcUspoN1ih5bRI+1Pj35/WWwzl0O3zQN7vgAscg7ZszlfUf/Ps3RKR3
         GaIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794913574; x=1795518374;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ChkKaHHAKUklGidpwJFPREnCjwZb6wuXyqrdGtCbZ5c=;
        b=vcbgsPf2AeRXkOZWgToOliSiII5sXnbtregNzBMWBGR0MLHXvmzuWCA7WgLJd8APti
         T3DXEkM3mNKDKevXpH51TRj3d+3RE6hz0bk1LB710L83HgiOmMtCea/wHAtRZSQWJRcA
         acE22hV9fBmZ1pVbkpHjZTaF8gxOXYiSeimBNrhxNQe1FX60tw7TErvPWy967eQrnZS2
         pWLUMyqO2VFZVSHANtdpJe6HOetkYIstPWV8fIi9sNh6Q/hqZjFSsxWMraA9W9yVrgXN
         9czhiRw6x4nX7og94sYf1YnOLyXCm1MsyoWgPc018VZS+clIKJQ53+jKNJ9cht1HS5eL
         7hmw==
X-Forwarded-Encrypted: i=1; AL+hErH2NU0Bq3rvpX6xUnZxHuukFfvJZar+iGk4XhI45TQi526I3KsyvtjELnONxpjh4sdBuZ8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Q/AUNZSTPb4CgWJeZHSdgCJXjtgnd+ZbDyloQl4ecC5VcEi0t
	V5e3il3XjwZIU/Nhdh4mW824OKaOlkfAZ1HuLqEBeOFi19oKbFjlxupW
X-Gm-Gg: AZFdTZcZBYpgNrooDPwkA6itwU8V5BSoiZx098pcah0AsafQlVTrXXiD1sg/MwrPQ5Q
	NusOpdmEyPwFqp5B7VCYH88r860I/kSUbpr4P2WqpCHtZYILZ5mKzfDpJAk1KZ/8CMEZQ6AKlgF
	AMmZlmiB9JcZiHJ8z2fEMP5zssGKZROcItxsWofBgGMAaIo8edaR7DHZ496rfhIO6Nluz34UCAY
	rJCOrfAblYPFBQugziNoPnv+/doQp2HF26XeWiMy24jqVtwjWHIvvWwh0CF3x7mExUyCwD+dyDG
	Lf1iNbcEAqrcbKSpnkGG6rJM9RWDcmxm5EBheMmcMl8iXr9btgdB8TTmvXKyB8WRrsjiFo00ZI4
	v7WmLdt9Z7TpVzEOoCG1lZGALJbqB6oZs8VwQ93FNRMrEfVgq+z+joDM/8ShAc95vm0YEiJbvYk
	nvbUS+sPh+gp8i61cpCYDYco3z3dVHoCFa6C//tStQO1bKPQUt3MkMcJqhCiYLkWIewhxRL/jKq
	DcMTlksFMRR0vTQ0nYasfujiOojIiW5+8KFBWzHZzth0YM7oaXsyt71Z4qmP2yG9wxXvFviML9V
	XtatCnmG2kigkkW6Pueda8+qYoC4NyxXHqx7PhPJKPGu1wj715aZSKMzJzoyu4yHPw==
X-Received: by 2002:adf:e18a:0:b0:48e:3c5f:a24e with SMTP id ffacd0b85a97d-4a3735b4249mr4831257f8f.11.1794913573701;
        Tue, 17 Nov 2026 03:06:13 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c69406640sm27345536f8f.12.2026.11.17.03.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 03:06:13 -0800 (PST)
Date: Tue, 17 Nov 2026 11:06:12 +0000
From: David Laight <david.laight.linux@gmail.com>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, "Petr Mladek" <pmladek@suse.com>, "Kees
 Cook" <kees@kernel.org>, linux-kbuild@vger.kernel.org, bpf@vger.kernel.org,
 "Jim Cromie" <jim.cromie@gmail.com>, "Lorenzo Stoakes" <ljs@kernel.org>,
 "Luis Chamberlain" <mcgrof@kernel.org>, "Andrey Grodzovsky"
 <andrey.grodzovsky@crowdstrike.com>, "Steven Rostedt"
 <rostedt@goodmis.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Samuel Wu"
 <wusamuel@google.com>, nathan@kernel.org, nsc@kernel.org
Subject: Re: [PATCH v4 next 13/13] scripts/kallsyms: Reuse little-used
 compression tokens
Message-ID: <20261117110612.1d61025a@pumpkin>
In-Reply-To: <sashiko-outbox-218682@kernel.org>
References: <20261117103352.1244657-1-david.laight.linux@gmail.com>
	<20261117103352.1244657-14-david.laight.linux@gmail.com>
	<sashiko-outbox-218682@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Nov 2026 10:57:57 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] scripts/kallsyms: missing syms update on split in
>   uncompress_symbols()
> --
> 
> commit 33aea03661ccead3785f7f56d31a3c8974eb8710
> Author: David Laight <david.laight.linux@gmail.com>
> 
> scripts/kallsyms: Reuse little-used compression tokens
> 
> This commit reuses compression tokens that have few remaining references by
> expanding them back into their component tokens or three-character strings
> when a more common token pair is available.
> 
> > diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> > index 42a7c99585c56..976b525c4366d 100644
> > --- a/scripts/kallsyms.c
> > +++ b/scripts/kallsyms.c  
> 
> [ ... ]
> 
> > @@ -855,6 +954,125 @@ compress_symbols(unsigned int token_idx, int compressed_chr)
> >  	return subs;
> >  }
> >  
> > +/* Change every occurance of idx back to token_pair/triple.
> > + * This extends all the symbol table entries but frees up a token. */
> > +static __attribute__((noinline)) void
> > +uncompress_symbols(unsigned int token_pair, int idx)
> > +{
> > +	struct best_table *bt = best_table + idx;
> > +	unsigned int sym_idx, len;
> > +	unsigned char *sym, *p, *end;
> > +	unsigned int substitutions;
> > +	unsigned int third_char;
> > +
> > +	third_char = token_pair >> 16;
> > +	token_pair &= 0xffff;
> > +
> > +	for (int j = 0; j < bt->syms.cnt; j++) {
> > +		sym_idx = bt->syms.sym_indexes[j];
> > +
> > +		sym = table[sym_idx]->sym;
> > +		len = table[sym_idx]->len;
> > +		end = sym + len;
> > +
> > +		for (p = sym; (p = memchr(p, idx, len)); p += 2) {
> > +			len = end - p - 1;
> > +			if (len) {
> > +				if (third_char) {
> > +					/* Adding three characters */
> > +					adjust_profit(sym_idx, idx, third_char, p[1], p[1]);
> > +					memmove(p + 3, p + 1, len);
> > +				} else {
> > +					adjust_profit(sym_idx, idx, token_second(token_pair), p[1], p[1]);
> > +					memmove(p + 2, p + 1, len);
> > +				}
> > +			}
> > +			if (p != sym)
> > +				adjust_profit(sym_idx, p[-1], p[-1], idx, token_first(token_pair));
> > +			token_add_symbol(token_pair, sym_idx);
> > +			p[0] = token_first(token_pair);
> > +			p[1] = token_second(token_pair);
> > +			end++;
> > +			if (third_char) {
> > +				token_add_symbol(token_index(p[1], third_char), sym_idx);
> > +				p[2] = third_char;
> > +				end++;
> > +				p++;
> > +			}
> > +		}
> > +		/* sym_idx is already in best_table[].syms from earlier. */
> > +		table[sym_idx]->len = end - sym;
> > +	}  
> 
> [Severity: Medium]
> Can uncompress_symbols() leave sym_idx missing from best_table[].syms for
> token_first(token_pair) or token_second(token_pair)?

Read the comment - it is still in the list.
Quite subtle.

David

> 
> sym_arr_free_all() clears best_table[ch].syms.cnt when a token slot loses
> all references or is uncompressed, while split_token() only checks that
> first->str and second->str still concatenate to bt->str.  If a component
> slot is freed and later reused such that first->str and second->str still
> match bt->str (either reused for the same substring or for a different
> length split of bt->str), its syms array only tracks symbols from the new
> compression and no longer contains sym_idx where bt remained compressed.
> 
> Expanding bt back into those component tokens without adding sym_idx to
> their best_table[].syms arrays triggers the errx() in check_best_refs(), or
> leaves stale token bytes in table[sym_idx]->sym if that component token is
> split again before check_tables() runs.
> 

