Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4692B368971
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 21:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772142986; cv=pass; b=tVVGC2YJHSNErOjDwHV8DkR8zpjx6WVGtk4llGKEWF9agFRvx/YVU7tGm/gdoWvPZ5gTZW100hgH2BgGzrqgWB/bN2g2b74b8lQzRGAho1PbC/WEVQekx124v6SvotMwrrV6bGstyxN5z43UAHKqmPv+1/OgD3fymIjAiAsQcLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772142986; c=relaxed/simple;
	bh=ubzl0nrerXJVdr22o96X3yVBWyBcT6n7SLaRG9gfXGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c3oURMPCj7VdA1osQ+b9YahDiMMcGEqSMitxq7VuOJVDBs39FXe503RjGQaoQd9KfmVZfMWwXGGfRcPV72QjTOhMBwUz3Mfd6FjunZ0VUcubL4InVBVnJlg2n5nvdx0yyoypV0HTsVMurjpnzXAvv25SSlPfOMqSFGc4W5uw9Ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCeowg1c; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCeowg1c"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso11130115e9.1
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 13:56:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772142983; cv=none;
        d=google.com; s=arc-20240605;
        b=V73E8AiT0EoUQGFWOJDdNL/35homButTRPbHaEqgjasR2shcMxat1N9YssGgPs9dqY
         ab69hYUEqY76NsD6V/71cQBa0engvYfqmuTz2gL1AMdfRgkrWr3XoPeFU7oSK1f3UuNJ
         YEAjUzx9j+jaM79w2hFff59FC2d0VbieSp30IBzPXuNW+uLxVVAxzdC8NZZ98PPJrg3U
         y2pyIXQkjaM+lzgI64aN7Ff5h90McnM4ixGLy9GtyOMnkiS32tB0SU3W7INYjHA9douR
         vd9QlzbkCCEVk3gRx93od4P/+Awrg4dcifUOJJl6qoU3nh5CxrZ2vj6IYqvfo02NkKZE
         pH3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ubzl0nrerXJVdr22o96X3yVBWyBcT6n7SLaRG9gfXGA=;
        fh=42mh1QYHA1B2nfoJk5Yj43rUdkiyfqs7zxBYjUTeJVc=;
        b=QVRKMHrkRqNFY2tsqfxmvX8YH5Uw4eVAM7VNEHtYR2R5+t2tlhhugDaYKX01X6uRNa
         kANBmWhMn/IChebbDlVlupsbP+DX/RxUd6umfQcjr0fkMsBmsVY7ESzbQgN+RBWPIVoF
         klyzrk+5YrL094Pv6I4wKk5/LAJ0HZvWuxKIrAuAm1WgKEtRmeq2qkm+9RhBIz4w8rPa
         chyrhvmXhin3+9U64I6Az7iZTrciFbL/L8B7JGZz47As/1eS3C0CuD/YXqVvfBDfWVYn
         dEr/2Ig4+vVbnSr9mXn9hjSThoxdkEnOFHu+th2zMTDGztWRQO/GkFIfYPVO1pdyJhgC
         Gu6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772142983; x=1772747783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubzl0nrerXJVdr22o96X3yVBWyBcT6n7SLaRG9gfXGA=;
        b=MCeowg1cX8ndLUYIxla17tcyLSPIRd+i1CsmwQtK1o59ili1ihNji3c6suCkkBaA28
         bkbIYFZtrajLMcihfXKGr32uoiZpraHxCOJjohYW0fSPRqYUdnsr5a5tJID7oVXKlBkF
         rRJFC1+ejfbMmVTxhs6p6/cbhUNcaUSCe/PVfBTU4esdwakIijruEzAiwJmdPZHt+7tN
         Pc4G+k+Wt1wpjK/HWPwNgN0Q23W22r1BgnWlIP+bT+awdhNhj/EIMixWBfGBPDC+uBFi
         Kq3dyrTnNxlvoE9rsAYU70IuPq4s797SnVvN4c5Wi34eW/Puoyq3PIbDESyePaYhqfzL
         aGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772142983; x=1772747783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ubzl0nrerXJVdr22o96X3yVBWyBcT6n7SLaRG9gfXGA=;
        b=ZchdU+Y9NYyTxEFXeBee0VS/vEp3JfgM3WKcLosgsZUfH6SKZxEnC1qXoeyiN8s4Sr
         A4XkoxNKYqg+up1lazisBHtGDArmIwWSRi8D9pZrMAcErBenJ3YXgwOuxbEhth9MbT1E
         nzugqKic0bCSxr7Hz6hNRnrYMum9CCfnBNUO4F8bPgB0G4rSqWjnmKw7l+UbmVtqxr09
         fthDbC9ZEk6qJKEr9OzaEIXlgs/AvAdMIxe3pBGwHfIAUHE1Dos6TZK5cHFrQZmeg+pU
         1JfRxdboJX0+1dFM1Fh5PSY/MvHdUKbPkIO0qsBL9T/hneVC4nWXP3hTxwSpo3diNYrF
         SQew==
X-Gm-Message-State: AOJu0YzSCl+hm9q+DFedHfuf8+wu83Alqho7qG9idNCd42KEub22Xb/7
	AeUETt7yIOby+vJziKw1YXu0DyiDpPrNRcbZ6gm5QWZj48psJoUaizMC8pVjVj8y0S4YryWJh/L
	9Q+xwr3WQtO/t0oy1Sfj/vaMDwcDpSMA=
X-Gm-Gg: ATEYQzzdRXTY5iqWUTHD0G/vtIb30uhQeNHTBWwsoDAJiT6zcKFrW2vUAuH9v8PZJFa
	sUvGmFvQCDmpTC/ynkHxN1UfWEVwECGJsmYD4/xwgWk4cqLrIoXMueLg/uOCrajMqvKs5C8XSTT
	5XuxDtoy3Gb/l+sO1yVF1XNiJ4vwFieBiaEvrBFLzNNIGkC3T1mj4mFj/0a1rMmi3vEdXiBfR5N
	svY3a0v5exdS3wf2z+A/BKE9M7q60il37g/tBOKI/fDqYLfDjUj2y0u3OChBee2X1fxSnJQBa7m
	QGFd9u7Oy3luv9f13VGx0l/t1ma7S4lISlJMvGOeFQneKnZT70lFOSUTF4jlC9RJxK2rlKqwCLb
	lZkG5+XLhU56xaH+nJj5VKWhgIA==
X-Received: by 2002:a05:600c:1f06:b0:483:7783:5382 with SMTP id
 5b1f17b1804b1-483c9bf49afmr5437545e9.27.1772142983320; Thu, 26 Feb 2026
 13:56:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226-skb-local-storage-v1-0-4ca44f0dd9d1@cloudflare.com>
In-Reply-To: <20260226-skb-local-storage-v1-0-4ca44f0dd9d1@cloudflare.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 26 Feb 2026 13:56:12 -0800
X-Gm-Features: AaiRm52GQ6X9DvTsRQ_mFSVEgOOXYizMYQZrtMbFf9A1yKUa07ng9nh92m8C2EY
Message-ID: <CAADnVQKVfyh3_OZshvYf7GJUF-ph2eMfmaQsxNgwBJd1AJgXTQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/5] skb extension for BPF local storage
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf <bpf@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Network Development <netdev@vger.kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 1:16=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
>
> Previously we have attempted to allow BPF users to attach tens of bytes o=
f
> arbitrary data to packets by making XDP/skb metadata area persist across
> netstack layers [1].
>
> This approach turned out to be unsuccessful. It would require us to
> restrict the layout of skb headroom and patch call sites which modify the
> headroom by pushing/pulling the skb->data.
>
> As per Jakub's feedback [2] we're turning our attention to skb extensions
> as the new vehicle for passing BPF metadata. skb extensions avoid these
> problems by being a separate, opt-in side allocation that doesn't interfe=
re
> with skb headroom layout.
>
> With the switch to skb extensions, we are no longer restricted by the
> features of XDP metadata, and hence we propose to extend the concept of B=
PF
> local storage to socket buffers - skb local storage.
>
> BPF local storage is an established pattern of attaching arbitrary data
> from BPF context to various common kernel entities (sk, task, cgroup,
> inode).

And that list of local storages ends with a solid period.
We're not going to add new local storages.
Not for skb and not for anything else.
We rejected it for cred, bdev and other things.

The path forward for such "local storage" like use cases is
to optimize hash, trie, rhashtable, whatever map, so
it's super fast for key =3D=3D sizeof(void *) and use that
when you need it.
The life cycle of skb already has a tracepoint in the free path.
So do map_update(key=3Dskb, ...) when you need to create such "skb local st=
orage"
and free it from trace_consume/kfree_skb.
Potentially we can add a tracepoint in alloc_skb,
so bpf prog can alloc "skb local storage" there,
and to clone skb, so you can track the storage through clones
if you need to.
