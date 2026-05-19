Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com [209.85.208.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8D34DC53C
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 12:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779194986; cv=pass; b=RaRcFR0NJoNeTh6SPlWM5+UlcvQklj6sJU3hMlkaLgcLu4ho/GRaank3rbtqyulLEuAywDBm8Qfz6yYYzBhHLgNT9l9CUi7sF5AQXxVAb15uJKbgtU0oAL9wSe9+aDIKOVRApQDcN0+CHakNSLGywVsbvttICxJTxlpCFt1fLPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779194986; c=relaxed/simple;
	bh=jfPV2780Bs9BUkpIrmBKLD8IB9nmDhWvo+NzhoVNkFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f8X/IZYJco7p67xgr1l/TzPrLkfWnjkcGVTV+o/B9Id14i1SHJBdbdPYcKd6xrRI5UeBBZsMPqFBrHDVboxsvOjQ/Af/C2YRmYsxYshjt4J94iBvXgincssSrjW9W2FKz/GR1w5ZPJhiZHl6Nnqa7maDvU/xqXhgwPGty8ar6B8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9jLI4eo; arc=pass smtp.client-ip=209.85.208.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9jLI4eo"
Received: by mail-lj1-f193.google.com with SMTP id 38308e7fff4ca-38e7c3a2deaso33480331fa.2
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 05:49:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779194982; cv=none;
        d=google.com; s=arc-20240605;
        b=ENz/Fe1fC2v+mko+nAhk1W8isSjBFT0eXbBM7L/Air0MJD0mKX740qEIKSkqR69Cox
         N+RZ/3+CQRL8IIrYjGavFzDC50CGueYLsHledeAiMEQMunVfKv7V+w6LJFwWup+Lm+nV
         xQqa+VOvFcMgLsWB2GPFq09Xn4YApgWqH9bS7BCW15iNvXywfgMSnWOzQKHlSG1pj1/L
         4yX1h+dGSuPnOVvxftoZbNTQesrrBxEZve+wkQ1omX2wyRE91IwAXnUhuaiZD+dM7o4K
         tXLqGLBVqdiYAWn5pejX9LeXRU46YYMYjLkxmQPGPYoiGIWwppnjYycWy/YPedfxmMz6
         UbXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=TptvFrw7YTp9kcu5BiXjspbxBVKusRMLEntVA9ShJ50=;
        fh=7Ui5c3jHfvQOKiDcMnbHery+oPKiqYtxHf9Ap+8esYc=;
        b=XHAZ1+K1nYa69cFEvp3LQtD15hYBvpTzHcWEexBp49FchlORpHxgern+D6RYj7DE4H
         /Dn0QCwd4PUOo8GCebCIKxIWIvcrtdye44001XNxCbdFfwbPJzYn3OPZWJljAVswcWDh
         tJAnD44ZEUA/RMJtuRtVnY/BLmWYIZPL3ZnJ9bUlyiuPuQbOTBRsI1qyObGL3TmXlIHo
         ucfE/VEPHSU0jVXoYQJcf5WgeYe8fFtGRV8mZjkfL6udl1oAxz0bYlNyWJZh/0Xk1HxS
         1CCUwoavcnixyHB11R+mR8Q9X5mpjeeZgk8Tu7/AwNQ+sd6O2XnBfd8jEsh5aa5z7rso
         6k3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779194982; x=1779799782; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TptvFrw7YTp9kcu5BiXjspbxBVKusRMLEntVA9ShJ50=;
        b=N9jLI4eo2vECRRoJjR0+xJiwcHFgpCD7gK2ufIuWiULajhYT4zFgikiZ0qzUnJ17mw
         3Kcg8i7wI9c5VBuSiN13PdFTM4OlmVcglvFiJZSd28HuGe6xrMTMr9pl9kQ5/SPnaffr
         a8SOdSzCsVdWgs8ex8529WHQ/kQdCL1L+/Ty98iNgH1fsWoIjObCZ+XqZEaMExjNQnt/
         iwH23AHFfK9+jPKVT4CxT5P2yM64PidlPio0Jw2Kti+1koR3PHhJLYhnEBMm9RstNcn3
         9KzoOKg2BFohCnmcPUt4wnVQz3HH+OmEo2t9JTOATgKfNantgdqs/O2JevFPqbl6NlGj
         pLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779194982; x=1779799782;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TptvFrw7YTp9kcu5BiXjspbxBVKusRMLEntVA9ShJ50=;
        b=eKomjooUx2F1Tu9COYjQTwkYbeLfFwMjps3IwLmBxtnSfWzokBkWxGAqKZNMaXPKTx
         5yKpqAbOIalh/FaZO0ZeBITa9rG+5FseeOH03ePPhjNTSqUbXiv4LsEGdKDj6Hw8WOka
         uWk9TCUIg2nZA5bIeTld707v4sDAy9sdmVWXPkxVP61bfsKeNEztu/5QGRzNRp/o3e5/
         myR3UHNDLGVS3opn+gIx1eWGA9J0nq+aY7gPr5BxeiKPMMn2m202Z3NLw4DJRw5oCSCa
         BihhOc2NQfNNulAfAcsDKHq6rZ1P/Cpp6uUse1xXg4P4Rvfv5kSOZCcOBVa6HWh8B/to
         Yv8Q==
X-Forwarded-Encrypted: i=1; AFNElJ9zvyOXyqiGNJoVpmMY6AXdxPAW02OV2OEXhob/6I1US5UoLBgERQrdzvbJfJ7eTB1Fazc=@vger.kernel.org
X-Gm-Message-State: AOJu0YytC+BRKUPkBRBOKHMg/OKrQvg/4ugimv/8LZKtakEvP3CIVjRT
	NtM9KtxxsqdwcUKYUSSg2hvJH5J8dEiPFS4jfSBgyfSR7pV/e4KiNwBVFne3pNpOFDJJzs6fLy0
	xDE0QLd7UyCQeKP6hZJHZzgeleLp1/rU=
X-Gm-Gg: Acq92OF/cMhnVemXTYMfoPouOkbGiU0ChgqCjvwyn1bN4HvSVHOc/TplHGmLenMOJa4
	o43/Hsa3SP5xVBbaGsmXFDYnFvL7taj9Z8jKV0QPPjmjlbgg4L1w5BNqHebss7uOBlpGn7g5uqp
	7fZcAkXnRRLNtPnRi+Ph7OMuE4456ChxQf7snbMYvN+QmaNqD6A8QSPt5ZNOpU+AaMYpu2sKh3F
	ra37OHgUIMZBAFuk0Wr9uOo1vY5N1G3vB7elvTMx7wCVP9ph4eMFztJ+s/DfZ4O4oD5bVqnvRjp
	U5biUukv4bGf1FAgIab+VTaMU0+XJw==
X-Received: by 2002:a05:651c:515:b0:393:cb61:1808 with SMTP id
 38308e7fff4ca-39561d2b1a2mr54005981fa.24.1779194982145; Tue, 19 May 2026
 05:49:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517121626.406516-1-rollkingzzc@gmail.com> <rclmtymkiaor247n7gwi6ggmpwi2hyu5hicggroopeohspfnyv@7ryrgezzs63q>
In-Reply-To: <rclmtymkiaor247n7gwi6ggmpwi2hyu5hicggroopeohspfnyv@7ryrgezzs63q>
From: Cen Zhang <rollkingzzc@gmail.com>
Date: Tue, 19 May 2026 20:49:30 +0800
X-Gm-Features: AVHnY4KBYOwaqhirihEC-ocC8POXVpSAtu8Xd7aeNb3NGD8F1HYlRbpjjVodKoI
Message-ID: <CAB7XQsGe8ZA_WRYcGgkOa--f+XdB6d98_g4VedbFPK01eH0rBw@mail.gmail.com>
Subject: Re: [PATCH v2] bpf, sockmap: keep sk_msg copy state in sync
To: John Fastabend <john.fastabend@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jakub Sitnicki <jakub@cloudflare.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zerocling0077@gmail.com, 2045gemini@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi John,

Thanks a lot for the review.

On Tue, May 19, 2026 at 05:32:00AM +0000, John Fastabend wrote:

> Important note here on where this actually happens. It will only
> effect users of BPF programs that are making the push/pop/..
> calls. So most/all users should not be impacted. Agree though lets
> fix this.

Thanks, that makes sense. We will make the impact scope clearer in the
next version.

> To make this easier to read I think having a,
>
> static void sk_msg_clear_elem_copy(struct sk_msg *msg, u32 i, bool copy)
> {
> __clear_bit(i, msg->sg.copy);
> }
>
> is nice to have. Otherwise we get lots of
>
> ```
> sk_msg_clear_elem_copy(..., false)
> ```
>
> Or just direclty call __clear_bit() is also cleaner.
> This is sk_msg_sg_move()?

Agreed. We will clean this up in v3, either by directly clearing the bit
where appropriate or by using a small helper if that makes the move logic
clearer.

> I think we need another fix here,
>
> ```
>            rsge.offset += start - offset;
> ```
>
> Probably carry in another patch. I can do it if you want?
> sk_msg_sg_move()?
>
> I think this is good with small cleanup. The bot report (need to check
> again), but I think it was calling out another issue with a different
> fix/patch needed.
>
> Do you want to follow up with the other couple addons or should I?
>
> Also please add a test for this so we capture it in selftests.

We would like to follow up with a patch series to address this and the
related fixes. We will also do our best to add a selftest for this. We are
not very familiar with the BPF selftest infrastructure yet, but we will
do our best to follow the existing tests.

Thanks again for the guidance.

Thanks,
Zhang Cen
