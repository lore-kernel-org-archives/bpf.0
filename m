Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC9933E374
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 19:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780602621; cv=pass; b=W1urt9p2cCe61Z6jAKB3A4pzau7KCnHzbVx8ej/8mHEgYImUu4Q+2hjpiwF5wFirBU7aZJeJZvdyAys4mjUknVWV+fowPVTcnOnw38gfyvCRl+0ZbIUBeCSv98QNAqJ9PbnLPTCf8VFCFEIX+TnGwNQqWnFMYPmhQG8rVxFHpVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780602621; c=relaxed/simple;
	bh=DIWCRG6/tICfZRRUUqTHZfGVMa1Dl8t0o0H4BHiNYjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C+2yYJmhimi9yiAV1Yqvu5qf3+VBivFpksSXKK7lI+dvCmybdKB+6/fhQLj/QgEw5diCPKdOTB6hEXjOoaDoLbVjM75FIojXlmodSL+cDNwaw/lnqR61r7eElOfJ1khUR9jnJvAq2LTJJZvzmuVF3449nebxO4IuoCEtKvYqCu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSVELsov; arc=pass smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSVELsov"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-45eee266c6cso905252f8f.1
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 12:50:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780602619; cv=none;
        d=google.com; s=arc-20240605;
        b=T5os/tuksECTtFG9t9l7fRBCtl0TG8tWdhqLztiNY4EGzwuPS59FW9+AN8cM/wNC26
         ZwBLP16W7OXVbmz0jNV2KSSdWZFHHIcyEWNr41UQRnS4CNz5uthIEUDKEtQ6G8xN5M1V
         hPCUq3PWt0eyQL+0m0+YqKNazFIyaFbfnRnj0nnFTZsh/ttTd0GkLM+KJXkQuzHwpwAg
         muCRrYX45Jsyx72Jvg1hFUpbvW1CHXYhD8rm17HWbz4xdDc5DEfawJIpyIxQEhqjoKxF
         gqYE9pg98SWqFQuAS56fhnbhj3fpBvGDiranbd8NOHt7f5JAvxQnFcFj4bP/OYO3jESH
         6t+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=JqQBsofmpxoXmTmt5o4oZiQxhoZRSXsmfUaeamQRvQA=;
        fh=8i4SDU7q5H/5Ugo9UN2dWdgs24pwCMyTM7U8+/Cg+Nk=;
        b=E4c9Va335OFXt450tz84oKC2j2TV+cpcSPtqPVsdwnipw08Gol2Sg8ZN9lkzjMLtlc
         cAFZ9wQKQ12VwxF0asoAazhLueQRWEahiptUqh9AsTQy6dRNSzgoE+UusXW0eu6NynmS
         zTICklK2xyr22zknnooOZFtcd/jcQs0Wtdc3ILsQG+1hIgEEpB6cOjp5BUOk74V37478
         ilrbahideBO3LnohKY0PDTvyvZREKicrfcNxfSZ5fV4++/o0NcsMgqWC0vqRBrbuG9uR
         xYhq8UhClL6ni2dXANyaj0CKBWzEl8cXhtJ5oqK5ti4aWyS9XMEEggbs8udSyQ84Smne
         U4bQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780602619; x=1781207419; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JqQBsofmpxoXmTmt5o4oZiQxhoZRSXsmfUaeamQRvQA=;
        b=DSVELsovtUDzhruhgEpGupavdPknaGe+ddSRkPAdhfC2kM/yLtCzEOufBpJVBCMH3i
         A+4KSydvpzyBt4YFUm4Lv0uc4/9UAmy3rUHcY9j/ovcGPApxjwRsWdPPABwxoXdjtA1D
         txuqEut3L8Vb5kqwoBXFkiEX2420UsyFUA1yc0eQU5X8YlGXFRJTJcSZJIgrRxQ5h7bg
         5i8VZnnZidllXedirHnP/5GPHotf50XaEMS9zS6F8+Ku+PtyRzz3L5S6/anxG0CuZAOp
         IZOGJBukJC3YehUXjmeQYt85Icpinh3lSTlMhyEAudaKYlUGTSkChFT1qbqlPLm7G9hj
         IlbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780602619; x=1781207419;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqQBsofmpxoXmTmt5o4oZiQxhoZRSXsmfUaeamQRvQA=;
        b=ndG3Hw36zIDMcssUDh41YXiekAyxnS7lsNzLG5Y7RgRVRXfT8OBSQdECdP7VVaxhO+
         MwJNzpZ0if+/cmuYSk58WA6epaoN/FVpEP9inl/PqMb1BY3LpoYZXUSWn/vbRnr1pGmn
         lzbdL6nqqk3JPjKkI7skrQ45AYb1noQ6dMyVqoJWhjb818rOfvNp2xy6013rl1/13Qel
         uYHxkCxFHvOGv3lyPuol4W9xxH8JUyKpnrUb9244pzsEMR3/3R0WTdjtsqFR8L0g1/L/
         nwOnH+AcCaW8tSOkUup0CPbwFviIgtg8UBJNsPQrIz2lEOLdJVTvpGzpgEYAA8ZNGwvh
         fLLw==
X-Gm-Message-State: AOJu0YzkC5vgGkUfkE+LqxRz6ZPxVn0j8A2TFvehIeFq5FoeF67nGes4
	SOzO+MS8na8L0vlkbXMbrYkulK+uQoQRBAYPwmTFXmtyq0ze7sdOLuVLDvtQPDyf0d0qZ0EdtuP
	z1Kr+rc8nMfz1esH3UhUhXNmUC5IFYuw=
X-Gm-Gg: Acq92OGka2HmqdORfxwgBXGCaeML6dwTduv4dSzlTZBfi1BTkDWBqqrl5MUUvRNopEc
	aD4psc8lSmU2zfOge5rcQa7fmDQpuhRc9wfPUn4DZoPTkYJ+7Q2efMXgOUD5ifeMLlxFP0r8tVk
	OnJwc+4DZfyfpVyugqttICrnRhACCtk0mGeWepX91TzjpNVvFvVB+3hDl7ONTDnvh7qeNINkRq6
	RDC75q9DSd36sQ5JRr9ArrWJnEjND9l+/ofONr5EeHuee25p/073ivnEuCn54RiXGKmV07kOJnn
	blqMp6x9LWTCsj4iS9cjeQ2MZwXw7xbKS40tz3Ea32igmLqi4Qwj6Ok9sQ/UiAGQ99UMM9lwDcp
	wcUfMv7nKCetphyt0KaL/+Z8pGGq0xS7eYEgXRYIWQCTXtAVuWjimqowPv0W4mSiDQxWz4Q==
X-Received: by 2002:adf:e906:0:b0:43d:77f4:7145 with SMTP id
 ffacd0b85a97d-46030506818mr620708f8f.19.1780602618844; Thu, 04 Jun 2026
 12:50:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFkJGRcALU7xgVjdikkiYKZp5C4tLMDzM_1kKysQcQk2huoZRg@mail.gmail.com>
In-Reply-To: <CAFkJGRcALU7xgVjdikkiYKZp5C4tLMDzM_1kKysQcQk2huoZRg@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 4 Jun 2026 21:49:41 +0200
X-Gm-Features: AVVi8CcPrkPd8YP4xUGjy3celIdLh1BTi3unURhn9tkJt26AntRKViS-dGFyyHc
Message-ID: <CAP01T77QjBHj-W3208H0Qhkm7eOwHVjM3ZitzA7orrc3FXom4Q@mail.gmail.com>
Subject: Re: [libbpf] C++ interop failure in "bpf_helpers.h" due to "named
 variadic macros", please advise
To: Josh Marshall <joshua.r.marshall.1991@gmail.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jun 2026 at 21:43, Josh Marshall
<joshua.r.marshall.1991@gmail.com> wrote:
>
> Cross linking https://github.com/libbpf/libbpf/issues/974
>
> I am compiling a userspace C++ program which is intended to handle
> eBPF loading and interaction.  This fails with "ISO C++ does not
> permit named variadic macros" on "
> #include <bpf/bpf_helpers.h>".  This seems counter-intuitive to me,
> but it would also be a glaringly obvious bug for over six years so I
> must be missing something.  Can someone advise if this is intended
> behavior, where remediation should take place, and how?  It isn't
> entirely clear to me whether this is PEBKAC or just something no one
> has gotten to.
>

That file is not meant to be included in user space programs, it's
only meant for consumption in BPF C files. What you mostly want in
user space is libbpf.h (and bpf.h).
