Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96586324B31
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 02:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792116165; cv=none; b=l4e0TzntpgXQiKmY2rSIaaY16i1IaHa50peNr30RlLLNftnv00LrtfXxlNRDG7OLj5+NbMMsdCsaSX4BlmJ9VN2tkiG9M7w0x9vN/nAmynjs4x/h28hRJT+r0iA4quBIlFoAfDa1dFKpDnVWzAiDWUHXEG2zLTg097aDoR3BJu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792116165; c=relaxed/simple;
	bh=jYNw7adbE4cRLooeTB8sLnNjqjm9gd59EFh12T2XtSo=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=WXIBdfE/qC9VzVwCUbKMokaxGP+gekU57oJTss3GS50br4CbqCwq7zoK++DGve8q85LxS+fPPX472vNEuTxI+BD/8ILYWFWT/4i9RA1mGuS6PBFU1MchwjUn9bPH9bsm4ukrSD5y1L8PCuIChffPwzW52eb0qHWBw2OdAtneuP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqRJmKU3; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqRJmKU3"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e98798cbddso673835ad.0
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 19:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792116164; x=1792720964; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XakjnQV5KhC+GbjpZOTFq6I9UHFSJAvipWtebZMTM6k=;
        b=jqRJmKU34/QOWFVAcCp/cVVgSkV+NacflHxpzc23CuQ7HSES3gT1gO5kubIuHqJ4N8
         BS7d+OGaoB2FhgXQGS0BRlUmvUOE+UhyojvIc+ou9McoAcBFZWAFFw+HdqC2akUIGrpY
         /3Cf+ftgo2QYHBZ/GRQq9bWfKVi3v53Q8ertQNl/87yxMWxe0Q2Ob9hxMFFEd3i+HKKV
         kxBdXgsEsJkfJJEpkAh64fEGGjWvXMx+1FAfgo4z831093izrPePy1Oc5GAUhaKW3z+c
         h9y2cqD6uz2+9WCcMYdf0wt34nq48K+q7VJbUYzfq/PVU0X6Mxh2HR3avzFaMbrX6ZWa
         +Y8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792116164; x=1792720964;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XakjnQV5KhC+GbjpZOTFq6I9UHFSJAvipWtebZMTM6k=;
        b=izHfycg+jIIDpAgH9luQ3eMcR4V75lJ89BZYoC3L0NVy11EFcILCxnrmxTlWSyID/G
         goqYtCH6nN6RlEXlvHt7Bp7kpHrbCmahtQ8jcoXGmqtXC/dM+JQwi9SbInH8+ylNGlVg
         F1tHPoGlVO7vQndR8hkqmqG5/Ug1bl/ET1ABhzM3mhu0xn9PCQRwO9kcH+kLsKA6ktvz
         GIGZHLWAIMzyoajgWCj+qchO3FKNNp79NlpDxzIxs8DGVmHi8rYL5qtD/nU2tpWlW67R
         Dtklr4oROWjQ6eb8aibY6qgAvj3yzKZ/xbA3fK6SGcvAGKrOw2WdRMTT1PKFppCHj11I
         5xLg==
X-Forwarded-Encrypted: i=1; AKwUvBxJKVHaKLidGj+kEacLm5D5LFbKyOecnNpn0XstjU1LT1tvtltfdhr+lQpZHoGYEpJqs7c=@vger.kernel.org
X-Gm-Message-State: AFq9FYIhHKixcEP66aFxghq0wh4v8n1bVrGF+emKOeoju33wFevVbtzl
	Fz1+EuCxUELcK7iQKgfCTpD6e9KBIuMHnYB+Z56wOrMZaSmH6+0x2U2W
X-Gm-Gg: AYBFou3JBvH2QDlqdfI7lwr3xzVZiCoJQf9U6lEIgzhSXT46uUMhVMZAaORz8Uiu6m8
	vDiTmsQxdKl2M+W7ihOwz2f2ljz5kbVeHa4WjK04lGpIPMaBdo+2pAy3fFjaHqmfFSfjs7tptev
	uH46w1T7VOvqMr3yS9pdEeFZfkoRm/FI18bUrgwR7GTxL2xukw0oz6iLcTYOtxC8OXlcMq+qlOz
	oZPwN8a5jSB5kiWK0XXSZA7QTrXShTR2PhaubUkfcaq3+tyRsmkI005HgDKBIKXV3O5/FlM+iOK
	taohaH4aDlFQSoFl0N9huIf1Y4+MeY9lPPcxMa2mnR63UBymPkkApQJ7WCsMTMf//kTXh66U97v
	02WbgQ1X4avXtjKsmOIYJYhctZZHxu+vuAE8GpMYbr+supXhCEBsP4nQE3ihVcbULe6MhFOGb0k
	m4w+3ozarimOFHXi9UGXrg3jAAIs3kcN4zj86jvylj2YGp82hDgKKajIC+IZNC/av6Cergn8ve1
	gPJufK7vDaj7kk8CPJ0tUMrRc/ape8vEeOY1S5e1kXCW2kT8UzOGsv7WfW/DFUPwPeT9hQ9Bnsv
	jY4=
X-Received: by 2002:a17:903:244d:b0:2d8:d4d0:7930 with SMTP id d9443c01a7336-2e8429a7c65mr172744735ad.20.1792116163799;
        Thu, 15 Oct 2026 19:02:43 -0700 (PDT)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e86925csm2955595ad.52.2026.10.15.19.02.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 19:02:43 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 02:02:42 +0000
Message-Id: <DM5W5RGVPBAW.2F70WVQ24HT6W@gmail.com>
Cc: <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v4 2/8] bpf: Associate arena pages with their
 mapping
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>
In-Reply-To: <20261014233442.8392-3-emil@etsalapatis.com>
References: <20261014233442.8392-1-emil@etsalapatis.com> <20261014233442.8392-3-emil@etsalapatis.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, Oct 14, 2026 at 11:34 PM Emil Tsalapatis <emil@etsalapatis.com> wrote:
> Associate arena backing pages with the arena's private mapping and set
> their page offsets. This allows the fault handler to delegate user PTE
> installation to generic MM code, which is itself useful for avoiding
> races with kfunc-related arena operations.

arena_vm_fault() returns vmf->page and finish_fault() installs the pte
today. That doesn't need page->mapping. VM_FAULT_LOCKED doesn't either.
tcmu_vma_fault() returns it for alloc_page()-ed pages.
mm folks were removing page->mapping and index from drivers. See
commit 6cdef2ddce2b ("fb_defio: do not use deprecated page->mapping, index fields").

[...]
> +/* Arena pages are not page-cache entries and must not be evicted by MM. */
> +static bool arena_release_folio(struct folio *folio, gfp_t gfp)
> +{
> +	return false;
> +}

The only place that looks at folio->mapping because of VM_FAULT_LOCKED
is PageHWPoison() branch in __do_fault().
If that's the reason for this patch then check PageHWPoison() in
arena_vm_fault() and return VM_FAULT_HWPOISON.
Drop this patch.
