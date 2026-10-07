Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171CC3A6F04
	for <bpf@vger.kernel.org>; Wed,  7 Oct 2026 22:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791413040; cv=pass; b=mfaj0MJVFIylkV1ZAdoS3EUQ3gyU3HwlUdrLa3tjRummcp+E6OqWo7KAEi4Q08uM4qdqXkBr9HcF6HMxx+VjwC69uAWnIwSsNcN752hlgItROfMrK6WlRnX+hotrHdbZwenS8RhAQnc+PFcdd9B5xCvfHWReRLS/OXylv12YqMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791413040; c=relaxed/simple;
	bh=wXp2WBZ6eLi9RGRaF0tTcJdYbVqJ9eGOd7s19JkBV3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H8yW+DQn2Rcd5Jo41q2P0CLHiRYlC+qJOc7CqiPD+sU0E+KxQZsWjNTt8HQwxyJRtgZWboLO21MyNFhc7KPYK6SkxMpZkqeeBkNLgqrugyJ/uspubYLn7XOzRvl4e42KjAyKohTWC0b0WiyKNr9Q16toePzgZq4+9NiUpahtPjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9S3yJp6; arc=pass smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9S3yJp6"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-81b54d0cb17so2084961a34.1
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 15:43:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791413038; cv=none;
        d=google.com; s=arc-20260327;
        b=A3RizBj6Aoz5T/JotX5QlohOCqwJDXSxSBHU6odY9/QKSSHnBIwXVWETZ35n/Rzghg
         MAMje8trjkz2ley5dqXMMi7zatPvO2lmm33AKJQHKgy8Wh4R8dpfs5yv/Biq/HhF+1Gb
         prnJqOqoyhZ4ksr1Ntq07awJ5Z8DHgpb1LaGcBpkQMJoBYvz9a1yv+I6wTSGCQv1CyZE
         VIfbwNN5/Mpkbf1fn+aQ5sJS9WlidA8h1ATNbSuIi8WghiHPs9pETrPyQlQV628MLRLv
         PMPoTcLyczMhicmTuWnoJHtk0W/t9M7T961IzubMigLRDebwjr5CLZuOCYoikGh+yobN
         Yi/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f4M4ighl28LbuAofTn6rcczAbDWHyquWNCn4KhlT8Nw=;
        fh=aGJtaxGG+ZiSSjNWLUmBM+2oNUL97Ka+vDFI72bjowQ=;
        b=jd+l7BFcp9BJntPQjSgg7NFL2zzTmFcatJne4BWB3P2V4l2RPoEhxiG1EMBUkom2/z
         VCXrmkAy5RoUPhW6KQUnwQ47J5HaQ0mfxutkXQFSpWOCC+glx+aef+uC/QUjnDg3Ej/s
         uw+rItpnEQ1lfoH94h29jH7E7R2y8ZNEP1dl1O5JR4VcVByr/neN2Ttt9gQ0Asgz7D1N
         iABL028O7EcuDcvjoqrfzOprLBcRpv9qqQl6tXCz+7ewHfH5U9f3JMWVLx1spaK27a4k
         WiULQBB4C1UwR8IBdjG8RrvZTFSX/mCB43PN7UI84aRcw6/SBgdLbAxiDz3NGcQ1VooF
         YYzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791413038; x=1792017838; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f4M4ighl28LbuAofTn6rcczAbDWHyquWNCn4KhlT8Nw=;
        b=X9S3yJp6KNPEFQI0rm3WN8SI5+J0vUXT+n/X/dVpMFSO19WIKpb77LrUi89t9PKOHO
         i40j9AUxU8cNWO6Bul4lOTRPoPCUqlL0nKaWCVORV98H19cNGVw0C/W3iNZU+9RTB6pD
         GkiLNWv02wTJDUzywRWGgoMZcnCY9EbvqlaFcKy7W2jv66+oZE34ZyF2TrF5tKOa7S94
         zDeelqok7dIYEamTTNXX/DDgktvdkbiTHALeB2+IKcPAZg6ZuvaDLXbmACYoLpV7mvbE
         6QehNK+CzJZOkUNvBstc+q9OmoM0j5/hTCAUp0/rBS2L/RyUHm4+4LHiJTV+YIuaiicC
         Zcow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791413038; x=1792017838;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f4M4ighl28LbuAofTn6rcczAbDWHyquWNCn4KhlT8Nw=;
        b=N7Moii4+OtTJoM+iCKAN1DCqkrYgK2qT6N372iQnfOi+dLw9JsxMw+7z2Y6yHHU+yb
         lWQwAtcFJoQwjQxYtUYukjc8FcsVUXj0rZ7giX41XUTpSe6KdqHZ0RJ5lD6MK+/vfGwo
         5PeHqyzSUIbfIjeINmKWZxsMKohXJe7breX3XO2CISB7JoxbwOHIxjt08yEsgs3a4Hv/
         V5H1+CF8vrrTxzHrtiQ2Ai95Xj5vjk1pq7R1B7m9x0sfpgnupZPT1nAqwMDy//CoKL3n
         y6cTJ530DSb3RRbIKj5wLCb3WNl2F5sF3P9yjowki+f1M+NPuCvsQRzolmr1Frqneatv
         dgNg==
X-Forwarded-Encrypted: i=1; AKwUvBztBgd0NrfME6LoWktbwKTTMtwYDzWCZ37AaniNe0tTVUAI+47IqWi4Ji7v+hg6ESGYWug=@vger.kernel.org
X-Gm-Message-State: AFuF++lYBQUuwY3/1SRHDIH8t4flONmfHDRyaxZoWS1SsxSbzmR8Kama
	QFI4cMtzKAjemW/lag1ThIhNvSSyT9PZKIg5er5Z387kC2e6x8Fv8xO6Nk8CV6smZMvRVClsHX+
	sTyBuvWCRv6ngrF6tx4r2ybxCgDUOsIg=
X-Gm-Gg: AYBFou3MHOUkrGPLLoJIp5jKwriKkm+ZjvmJmTgxw7r1YGDfigvYIap7VxdOdIkv607
	iE41CUxctpWkUhPutsIotXcFUDnvn+Hr1C1td17reSNQ7pT6FVLz+iMcX7tyyZTihmr5JFWwpug
	PZtlLtiJpQJbD+EVP2gJCJpbEKAdELFD7mioWPIsOirR6ZCsnGLmf5yPeBEnO50plA3uAKhn8LO
	ElHuwCWnaMRhj4XhGS7mniiTRXAu3+2AJpBFdMZUNSsiniBHpXqHiI2Z1xkJfxBgOd/ThassPT5
	qQS7ZwX27n0ADucK8iobj6Q/TzpWneZoXlr3r3LYTziBt9QwoML7Pa93
X-Received: by 2002:a05:6808:4fe0:b0:4f9:e0b0:37af with SMTP id
 5614622812f47-4fc4668327emr4385313b6e.27.1791413037808; Wed, 07 Oct 2026
 15:43:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006192601.1875100-1-kuniyu@google.com> <20261006192601.1875100-8-kuniyu@google.com>
In-Reply-To: <20261006192601.1875100-8-kuniyu@google.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 7 Oct 2026 15:43:46 -0700
X-Gm-Features: AclHuK_UHYZ6uQjTEXs9YCsW6Li1_8D6VcWKkqcNEb1mLMqvBsoPzksAsgte3gA
Message-ID: <CAMB2axMFXNUWE8O14ONHQ8dpHpQqzBR_BeG4Ygd7PR9X=LuawA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 07/10] tcp: Split out __tcp_set_rcvlowat().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Emil Tsalapatis <emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 12:26=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> We will add a kfunc for bpf_tcp_ops.{enqueue,dequeue}_rcvq()
> to adjust sk->sk_rcvlowat.
>
> These hooks are triggered
>
>   * when the TCP stack enqueues an skb to sk->sk_receive_queue
>   * after data is dequeued from sk->sk_receive_queue
>
> In the enqueue path, tcp_data_ready() is always called after
> the hooks in tcp_queue_rcv() and tcp_ofo_queue().
>
> If tcp_set_rcvlowat() were used as is, tcp_data_ready() could
> be called twice for the same skb, which is redundant and also
> confusing.
>
> Let's split out __tcp_set_rcvlowat() and add a flag to control
> wakeup behaviour.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

Reviewed-by: Amery Hung <ameryhung@gmail.com>
