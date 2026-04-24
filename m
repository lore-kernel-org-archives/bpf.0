Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E763E51C0
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 19:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777058507; cv=none; b=RY9GTdk5pZLW32qVyzkIhfppfOCclP+/W6sUFFjnPdVsQy4SE7L6GDKnYloB5jjLKD4ZqJ0EHlfz21JaWIqg4WICFLhO/VNaNXc2CVDCbzW+w74c2DNR7X9gW7WYAYOOFTUwDPDwH+13XZFicGkaZkRIYM9dSCUk1qOLmsUMW3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777058507; c=relaxed/simple;
	bh=+vPpUWsYwpvZDuiQ+l6q7qOqmkavzTvyl/AbD1vaAoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B91TkbDKC7Y+iDaMXQOYsE+WuqBns1WOPSnHPzOBloPCTyj1ozF4NemPQX/5d+OJuJRFEOQbGdhQgCrLczG2Gv9RNlrBBXktdjA2snDjHIORBKjAh4GH438UY+uV04pFaP0fbZiex+KCpjBpsvExJxOdcFNkAHpTpvSg5Q608fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZzM79eBK; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzM79eBK"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82f33d28c1dso4545298b3a.3
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 12:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777058505; x=1777663305; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QjJdUnid8SU6MMGKvZIycfLCz20mR4Vbg4ZJjRQz0no=;
        b=ZzM79eBKu00o+aeuYPCYRYaqfIPDxTrI7e7EyX3Oz/jkU0WHtxKS/ZSYTMOOFCdc2p
         zZX+W6/RkkQfeYsSsfXVy/xHdBTnKwjl+lthOjh9B5R6MNaGq6Hgi6/38Z3JzBGEHdEh
         TME88lSYh9X4JNkVShL3ugxdY1RqNN+p6EXZKuzCr76BiWnm7jBzI8ME0jlbN3w4kE/h
         /NjJL4UZG765IzTmvsh4D0HNr1Bz8XoOK4z4gnINIMZHGb3p36aNd1VBDI8Itgk6JYkk
         O6g4RaT4dGCCN+LpwyvWIP9+yDKSCFuJ2xXPt+DqF2Pdejc66/d/Q8ozmvxJc5XRS3n+
         TxSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777058505; x=1777663305;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QjJdUnid8SU6MMGKvZIycfLCz20mR4Vbg4ZJjRQz0no=;
        b=AOLCU/oIUBlAPmWomva7PsjkEOW166P5as7wbfCz2uC9uacIEM8wDFg+k6gEn80fpe
         NsL4AQSaU2/zLkHGy5rbi4KnzgcsjLR4Vgf8dB/eAIk7suwLcMeQ29XliKQC2F+tHeHL
         /XXGeBriQ5Bcbl9wc6MNFB2O4813mqWnnZjL5ReDAwC/PZJVkJBOC7ERty4723kjMUXP
         yddF2woJAUTmwU8L2WU8kvhASe7sjsgUXpaURIEcXHJbKTAhM+OJm7VXdXJGwkKw7bX8
         4K3eHd2pDzXHHPgizqXkgiF3nodY15jQ09Nd9imSS/vMVmNKiTrcmM2gCzWVhsFIt3Dt
         2QGw==
X-Gm-Message-State: AOJu0YxbewqrQZfHKhMlnC2FRLRUYprzLnJysZWAdOWKr6ZgbLgM70TU
	jUCRn2mUF1ALCDWXykG6mL8OO8DSrCR47YjN6VlKmj47thWm96ngF26yenNiqrdd+iyUZg==
X-Gm-Gg: AeBDievlvS2T6fW9zMeMtGfsM4byo8bqXrZuwtB9UVjSFoBKo0+iLGj1ZHL9IiCy4wE
	UuINbU16qgUUiJ49tx5uOG3gZ9pFP5+0ANZfLZFuLaxcwW+iMSS+kplvANOSPT0lROBaKo+Zg6A
	a43s6qszCPgW63/P/MGiWPGTveGiRfdRsgkWM7SU3RIy4hKtYiBX5OA155OnToRN9JlCbdduJ9A
	NXdqZsPNAqbeWL9kw8lTLMvxbYkMg4q6ts1xUkChwhLAb3L6lH12bPTdThoQhtCcsx+Iyu/FuDI
	8jzw2ayXF58bp7VHw/B9Fo5X+0zV5DceEejg59ULsNw0heMcqie6+mXh+33+wM1w5BF9DKQlEvz
	+WBcHQIoDGbG7C0ViokR0TnsbeYrEV5oYEDiU6jUy06/KXEOJeqym75+A4Wm4iw1sctZ1gkcwdT
	qcyzVQpid9XStdtEvwMCg/Xm6TLgNmtiFz704yMe6rXelV7Y+ltkBEnLHz3xlzMQ==
X-Received: by 2002:a05:6a00:bc90:b0:82f:1e5d:db62 with SMTP id d2e1a72fcca58-82f8c885af2mr35569108b3a.12.1777058505272;
        Fri, 24 Apr 2026 12:21:45 -0700 (PDT)
Received: from Air.local ([198.176.50.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9819fesm24451492b3a.4.2026.04.24.12.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 12:21:44 -0700 (PDT)
Date: Sat, 25 Apr 2026 03:21:39 +0800
From: Weiming Shi <bestswngs@gmail.com>
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf] bpf, sockmap: Fix wrong rsge offset in
 bpf_msg_push_data()
Message-ID: <aevCw8YFsFdjyjRh@Air.local>
References: <20260423155807.1245644-2-bestswngs@gmail.com>
 <20260424155913.A19FDC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260424155913.A19FDC19425@smtp.kernel.org>

On 26-04-24 15:59, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 4 potential issue(s):
> - [Critical] When appending data to a full or nearly full sk_msg, bpf_msg_push_data() reads the length of the wrong scatterlist element, leading to a buffer overflow or ring corruption.
> - [Critical] Missing bounds check on the 'len' parameter causes an integer overflow and a massive Out-Of-Bounds write.
> - [Critical] Scatterlist shifts fail to update the msg->sg.copy bitmap, allowing unauthorized modification of shared pages.
> - [High] Uninitialized kernel memory allocation in bpf_msg_push_data() leads to an Information Leak.
> --
> 
> commit 15a0d48ce1bdcc5941167a3e0c2a258bb5038277
> Author: Weiming Shi <bestswngs@gmail.com>
> 
> bpf, sockmap: Fix wrong rsge offset in bpf_msg_push_data()
> 
> When bpf_msg_push_data() splits a scatterlist element into head and
> tail, the tail's page offset is advanced by start instead of
> start - offset. This overshoot points to the wrong location within
> the page or beyond its boundary.
> 
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 5fa9189eb772b2..a7a9ea4cb2f9a4 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -2860,7 +2860,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
> >  
> >  		psge->length = start - offset;
> >  		rsge.length -= psge->length;
> > -		rsge.offset += start;
> > +		rsge.offset += start - offset;
> >  
> >  		sk_msg_iter_var_next(i);
> >  		sg_unmark_end(psge);
> 
> This isn't a bug introduced by this patch, but looking at the earlier part
> of bpf_msg_push_data(), is the len parameter bounds-checked?
> 
> net/core/filter.c:bpf_msg_push_data() {
> ...
> 	if (!space || (space == 1 && start != offset))
> 		copy = msg->sg.data[i].length;
> 
> 	page = alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP,
> 			   get_order(copy + len));
> ...
> 		if (back) {
> 			from += front;
> 			to = raw + front + len;
> 
> 			memcpy(to, from, back);
> 		}
> ...
> }
> 
> If a large value is provided for len (e.g., 0xFFFFFFFF), could copy + len
> overflow 32-bit arithmetic, resulting in a very small allocation?
> 
> Later, when calculating to = raw + front + len, does the zero-extended len
> advance the destination pointer out-of-bounds, causing a massive memory
> corruption during memcpy()?
> 
> Additionally, bpf_msg_push_data() uses alloc_pages() without the
> __GFP_ZERO flag. After copying the split element's front and back parts,
> do the middle len bytes remain uninitialized?
> 
> Could this allow uninitialized kernel heap data to be added to the sk_msg
> and leaked over the network when the message is transmitted?
> 
> Also, when appending data (start == msg->sg.size), the search loop terminates
> with i == msg->sg.end. If space <= 1, the code executes
> copy = msg->sg.data[i].length.
> 
> Does this read from an unused slot?
> 
> If the slot has a garbage length from a previous pop or shift, could copy
> take that value, causing alloc_pages() to allocate a smaller size and
> leading to a kernel heap buffer overflow during the subsequent
> memcpy(raw, from, front)?
> 
> And if the garbage length is 0, could it skip the if (copy) block and
> increment msg->sg.end without space, corrupting the scatterlist ring array?
> 
> Finally, when scatterlist elements are shifted in bpf_msg_pop_data():
> 
> net/core/filter.c:sk_msg_shift_left() {
> ...
> 	do {
> 		prev = i;
> 		sk_msg_iter_var_next(i);
> 		msg->sg.data[prev] = msg->sg.data[i];
> 	} while (i != msg->sg.end);
> ...
> }
> 
> Should the msg->sg.copy bitmap also be shifted?
> 
> If a shared page (where the copy bit is 1) is shifted into a slot where
> the bit is 0, will it be falsely identified as a private page?
> 
> Could a subsequent bpf_msg_pull_data() then pass the
> !test_bit(i, msg->sg.copy) check and return a direct writable pointer to
> the shared page, enabling unauthorized modification of read-only memory?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260423155807.1245644-2-bestswngs@gmail.com?part=1

We verified the findings locally with QEMU. Two of the four issues are
confirmed with reproducers:

- copy + len integer overflow leading to heap buffer overflow [1]
- uninitialized memory leak via alloc_pages without __GFP_ZERO [2]

Patches sent for both.
[1] https://lore.kernel.org/all/20260424191602.1522411-3-bestswngs@gmail.com/
[2] https://lore.kernel.org/all/20260424190310.1520555-2-bestswngs@gmail.com/

