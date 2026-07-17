Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05031F4181
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 23:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784329283; cv=pass; b=FBJbLuFyxp9fzpRHWRusQbXphg63FORueAhBjfqwVT8sUWLhOpN8QfMdlHF/Czt2o5IVbuijH1so6LuuhcrLAf7S58geE9y13WT11+t7T/HdzLDhPABLUVdQiJTp2kUGYtZoXuM9unJOvIxosjy2c0lYt3uzeNYOSeUrCamCeTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784329283; c=relaxed/simple;
	bh=2ARRpIxjwT9FQVCKr+NXXIX57kU8jVAej/m5ibpnIxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EmXF7hlW3sQPWMnUWqdE3iX4bnB9Wv7tSao21O06iAHk3fGi5NhxU/ia00CvT+3NUPtE1mnElQsYsOMyC46FpsQ7wvjbWRHz9Y0WQIgu9DaLyxjK16xgPwWB1BL2CSBHnI4uZ38J3YzHSQIJqi85XvoJ++tOgMatnZvleT6JPd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0/6bYCk; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0/6bYCk"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c15c7d22070so1092635066b.2
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 16:01:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784329280; cv=none;
        d=google.com; s=arc-20260327;
        b=VRrxz2SRRh9aq2kFgHf0EkL0URFfH05EiY/QSJpjmCvu2AbV9h03Jcgjqumuv4maGw
         khtxhoFSU2G/OWj6WNb81Z0j+lgEjoIsyCMLzIDn8pJ/Sy1jlwACrviELBm1SmJJfeZY
         h7H4IEDoNBMQA0KP8UxZ3VgQwIyhNPY5Fc+Gid2YkAJoFCYqDgdcXdjQC+Sltz7ZUNPL
         mtZ/t8h8LYB6es1oDRlEKFNFjNBt19fTpCyTcy1e9B6DkDlG9j0ydBKcIfUeKj4acZt1
         ij7xwCPcG3Q9UaYJRQ5mHTxirkrzWtj9XfrOr5Rpdbla+VQHxDbRzeNTA7JZU4bzRdrs
         0wiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2ARRpIxjwT9FQVCKr+NXXIX57kU8jVAej/m5ibpnIxU=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=dfRsg30mfG+DWMT0DvssnJjOP+lrw3R4X2i8d3D6/R3tqSPdByNntzGJCmVEZNYZdJ
         HfSawpM4BN3B3o8i3Hky8SQ60yFyuYLYZ6MQoZ9zE6QjSWSeyyBnpduanhWSD2ldxrm+
         0W3g78pihs29RtP3qdGBRjZwChB5YTkv/6w5KQLJN342IJzPpcSvLFBOKapwgZWUeSHR
         4o+yAH4Vv8AAf74khFsGXjB7U3KlNSYIHZLQ0Q3wOh1K9gtl/N5GnPrOUi3ohoVPpxzK
         nl/Nz8xeEBtUz7X8w/jRM06xOniG7AN2RPOD3RzplDruHtzJAt+GnAr4e1t+ZFxRaQdr
         YAWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784329280; x=1784934080; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2ARRpIxjwT9FQVCKr+NXXIX57kU8jVAej/m5ibpnIxU=;
        b=P0/6bYCkYW6Pn8gfw910S4CEqDZGq9z7XtyvVB4xwwoEExH1EYH/BpxNBff13ReuuX
         Mw2hlh0MPmcyXxVxkj6V7zrIB6inLY/f3OMRP+R8LUnGlGvvEEf7lK7Alaty8RYLaBc2
         QjRv4pTpazbVP6uRppdBmkumvRs3HDzFpWbBVjq9gyvBTw0o3gG0avLI9ePvaLIBoO+I
         w+arcBjrFg0iKRrZi2WNp8bNmcxFvAhIvkPMrx3tE+ki3ouvGntZ6R3Pe5WrHc4WlW2D
         h4q2rv6MW1WAO+lR/xuo8xSff2+iAWhTMO36Lsj88Us2dqHirrFQliTxZidRnNp02pUH
         n76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784329280; x=1784934080;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2ARRpIxjwT9FQVCKr+NXXIX57kU8jVAej/m5ibpnIxU=;
        b=FdvcuEiYciYGFkPSAe+EzVqImOzlmuhcnO8V580yHBr2bJYswQga/PHD+pV6O5DqZu
         5V806aNLf2F492E6f8gjXZ19y0tyiLmhh/9JRT/FaOlj7tyFawBk38LgY0J1cs9VjqOA
         ldmp9w27AoM+BSoEFK5r1hZZcSpBNY/WbjYRkiDeKCiprjvmppBSsmPAawIR607b5Syt
         bTnHGQ90ptnvsfsPzQYy/rxvRzvrFpHBCQA/MqiPzFnqpeioQtb3qe3L8z4nESI4itIG
         a8o56skBkAZOf5fEZJ5JvE33LODOpKbGkQjHFGrn9+imUQjqnzYdpIfhuH/o68KuK7vs
         wmbg==
X-Gm-Message-State: AOJu0YxPNcgRqc3sHwgIH5HV7crQyidZ5Ubes+NhpJHjD3zOOyxqASnz
	sGe+irQzYsPbzCJfIV/Ab5Q/KoDK3fpU+aHcppgMUh1NH5pE7cOB+KpArr25Dz9PHlgUAxUSb0i
	f6GUAj+t4TwLwauGUjT6NF2QygmMuvLm9uFSgnF8=
X-Gm-Gg: AfdE7cmivjzfbdc973M02xt7rPI1NKDI0iOJOfTUn0rdaNRPbTvcQuRSCk1pVwhK2Eo
	dcxrT2Qkt07myDpDBFhTicVkr5DIPIpkZZL3wtQeqL0XJEH/wdwpBQE0bOzDgMe6EZA4WOtCQgU
	cnmOSVPRCbmjB+54JRWygk1KZQeSzKf/iQpc+fPmXd3QU3cdm/CGoAZqO/vCXSXQSrsM5TWK18P
	TnCDU3z4340ukdYQWZeWIU0Fo6IHcKr6uPqqKEFv9huUo15M4tyrO4xkDSErkta
X-Received: by 2002:a17:907:8b91:b0:c15:a487:3482 with SMTP id
 a640c23a62f3a-c16b46a743bmr207455366b.21.1784329280000; Fri, 17 Jul 2026
 16:01:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717190544.257306-1-main.kalliope@gmail.com>
 <20260717190544.257306-3-main.kalliope@gmail.com> <20260717192714.25C241F000E9@smtp.kernel.org>
In-Reply-To: <20260717192714.25C241F000E9@smtp.kernel.org>
From: Nicholas Dudar <main.kalliope@gmail.com>
Date: Fri, 17 Jul 2026 19:01:08 -0400
X-Gm-Features: AUfX_mySWo6od8t_U_EnSE_TFyGTib92677BpOQma3XswU8Zn8TPXEff4imF5WU
Message-ID: <CAJZwKkgAcZCM104J6qDn-OR39cEGcMy7ECg3xA7yELJq9krAqA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpf, parisc: Add support for BPF_SDIV and
 BPF_SMOD in the parisc32 JIT
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, Jul 17, 2026 at 19:27 UTC, sashiko-bot@kernel.org wrote:
> [High] emit_call_libgcc_ll() swaps the high and low 32-bit words of
> 64-bit arguments when passing them to libgcc helpers.

It does not. I checked this directly with hppa-linux-gcc 14.3.0: for a call
with two u64 arguments, GCC places the first argument's low and high words
in %r26 and %r25, and the second's in %r24 and %r23. A u64 return uses %r28
for the high word and %r29 for the low word. This matches
emit_call_libgcc_ll() and the JIT's existing normal helper-call path.

emit_call_libgcc_ll() is also the existing path for the JIT's 64-bit
multiplication and shifts through the stock libgcc routines. Their test_bpf
cases pass, as do the ALU64 signed div/mod register and immediate-magnitude
cases added here.

> [High] The parisc32 JIT silently miscompiles the BPF_MOVSX (move with
> sign extension) instruction, treating it as a standard move.

Yes, and it is pre-existing and separate from signed div/mod. The JIT
dispatches BPF_{ALU,ALU64} | BPF_MOV | BPF_X without inspecting insn->off,
so a sign-extending move (off = 8/16/32) is emitted as a plain copy. This
patch does not touch the MOV path; the five BPF_MOVSX test_bpf cases fail
identically before and after the series. I'll address it in a separate patch.

Nicholas
