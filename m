Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793754885;
	b=yE+elEbRxULYSquDfbGQCN9pZTne+9HLrQCmov0QWrhy5X5+w9526bOcL2hpa6qCu7AD
	 OR2D17pWRNHspX5HzmfWSJGiOBcYxz/768uHHn2PyLtjRGuHXyRpIWZGEwCIBJ0N9puGo
	 Ir64ehflMD4gyplacH/f1DSF7ajpStQ+sEqyYE9KG9RKyL/y2sYA21GWJ4K/W7dJTexyS
	 0CvrSb76UGgufq78CzjVFbbukXBy9bLXXlPzp/Ga92znPwQpO+FasvVzyFg5br3XUfCv5
	 qS4iWciZb1/jAbMChgXgNYJZBQ6MHEYzJVmyBJ92IMgUcuE/a9w4uCfoh+PgqonCNVw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793754885;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=iGrlFhobszoDubbYHr5z1P67t+I99oDwFpibAkY+FJc=;
	b=GeHpctE3vNv+f8Ol16LUFk3I4gJMpDpTJWY6UtyEWxoDWuf1gDVpTTgJhfppGT8czAe+
	 YTyHFXWRMkAFUVzmRpb+fcYjk+W1ruMUMY7bYQf9VDJzZ4mpBvhepiwn3jeWYHWt760kY
	 REXyhLewrrOcbZcoGXVIv6JWoh9MadnazIghpRTxAAHJ0QFPxKpGJjtp0lIvWybcNT0ee
	 L8szmUeEyw5/426Uwf/hhVDc4rtJI2WE0Ftrs7QP3ZiWTumhb52x6MtIT2j/zKfhvL7KU
	 GI0g1qVETuxtSw5SggHHiDY6hFKaH6kb5sKqV9N+zFrIyHZRnxX5zC5eJV031z0nQfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IR9x7CF7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7E8606A329
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 01:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B7E8606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IR9x7CF7
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b1aa27963eso2008142a12.1
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 17:14:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793754879; cv=none;
        d=google.com; s=arc-20260327;
        b=Qp4TnwdMAuWr6j//MGo2yXO9B3jgwPmuOtNDjJkQovWeMDkGtwWMwyxwdW3TPLWJm5
         1EoNvWxwxB0skmwjnjRPjObXHVl7tGJUo81r8c19eQSXRAr5ecMwlPKKOCFgnk6K+RDj
         +ktqFuvLWztGyMX8l2G5tyU0SZrxlFGH3QMSNCCHgdlD+yVpH+STtv40CvzHV3IYDn2z
         Yyi/W65Ag21ueaOiL8a5C5VJ+vUicnu37foYC+qw2bjtSJOKXE0808rsFcdApmUP5fid
         gA6I3OdE2Lvl+Vq+rPocjYpwBgtZVuc7sqI7CarCb8/VfZI5KoFA6KzbFLNsp441smYb
         cLdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iGrlFhobszoDubbYHr5z1P67t+I99oDwFpibAkY+FJc=;
        fh=SfE/31dJuevlToHxgKWmdUzHJVwHl/oEdR1J5U2eNe4=;
        b=efCVBZ4h9JU4spErIxPtN9eli/GhHSZrEjMZxmRVbQ7wWJIpzS+Pa5dxTujV0tm5n3
         F5GJ5xE5N3rmijfTR2d/8aHSimC9PFbEFRZ+xK6Q8xjksXIGyxd2hSXKverUtgTv/107
         II/SzSzBjN+wGCcrYQWX7r/OrWFkXvRkk/nTlfxNg4cMmXAj/dUwB7NypjZeLhs+r9uz
         0W2gT2Ps0gmfKQiTGK25fyTr9sc8KBGvYetxXknRF6ejJYHHM1QDI8g5zc6CbIKyr+Ui
         AE+F4SjCabyFB4OTaE5uM2eh9pYz4cJ7FzPxRF+Su+OqdZ5vn8pgO6Kyi1+ASmgxg57F
         XniQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793754879; x=1794359679; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iGrlFhobszoDubbYHr5z1P67t+I99oDwFpibAkY+FJc=;
        b=IR9x7CF7c4Mx0rniIXPJTap8Sl2/dr9gnbELz6lBJ5PjaAf02D1YAm2LSs37v81qCo
         DJ71amOTkdnMI00EPyhPmP/6O+dR1fHBGhBB8N08HS6IJb3bavA83yLJPIT5q1bmVYfO
         U9I8Mv1AhAISD9gQHYCQU9CqQs9uRSuFf/GBXxNes4jOmAx8FJ1/EC6+PRLfHwtyJlGh
         4bs/oRUDp3W+5e0rZ33XgLzI9zfcEnyXv3UPZwfkyHp9gepUycTy312afEDxLJBu+uDY
         JrNO004oX9+ApUMczZEAcZ/liFPBCKXYAxWJ3CGOVdhpd9Rcsvf05tTRbO/lhbaNTijb
         aS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793754879; x=1794359679;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iGrlFhobszoDubbYHr5z1P67t+I99oDwFpibAkY+FJc=;
        b=cJ1blnyOOL/1bWfrpnQvQuHujeA+M6TFQgtBwghmV6yCvYVoQ6CiRTUZoTPaUCJRGu
         sBZ44yQtT6/MoOEKTkHegHhAyev/arUW15tqTwwUZ9uc8qbDeHsbhPDrNjrHWlgwPlv5
         5NG9BbBwDAfzM06QnTnYwmbmUJveeNh0uii3vRS65+jbIgOlhryj5hrGHEmPkLOfqqPe
         SmcKeYgvaBtdWfPgz4l0a7+rh5KcgglgOPojplFKl8T8MvPbTqyxq5jCw0z7na54fG+M
         eBITJy1SGs2/6IIbxsNScMcrvwSJ7lPEwF5a4Mxw/3s9tXXFluE8CKArNg+OFyib21p/
         0hPQ==
X-Forwarded-Encrypted: i=1; AKwUvBzBn8zmy+fUD3HYlY7mh4hXdWHQRxmoT3Gg3tuzFCHDfPIxSnN2slkl3LZSAcr4BqLFmic=@vger.kernel.org
X-Gm-Message-State: APuU4Z+HYt/qXdFmRYBfdOOfDfYfUcV8+nkOxBhkAI7mnG/D7jp5pEKW
	54axx5QJeg5VwQwc65N5+q+6wulU239+rT02AA2e3vQt8zYyUMOxE1JIg0f6Bi8LmiY+JwXqeJ5
	saVCjNuYolviXF5pPBtFKBeOfZVWoAslZE4oGQmha
X-Gm-Gg: AYBFou2/votTjdY9XQAnkIJV9u7ljqM7MImkPrPhx/nq3B1A1TIAGcwZuKLA5wDqwYi
	sCG9KwodvznL07X9LVLRGF4HSmjQ16HgRc/EHuiQfTtvCMGCHQ+ha94vKifJlvRsTw3AeA57gRs
	WUUgET/9XwK0pPWFEdR7+LnOMxsKPjm5+vPG6cG5SVqz2W0dDs5Ho8Ikkj40HpldiGQ1wq9NPdw
	x9g/hCRysO9IqEm9fz7UlW55LkLY5fQybwMyad4ImSKYD4PGFj5McDTkFuD2452jO42A9gEgQPz
	CA7RSBBFmdSGpo0al1yFiePfVmLcb4FoM6F/AS9ktYhKUDxxyx5iJSAe8hB+YUARcBn7n1CdJWe
	8rYEwqIUkNij8+6QT8SC7Mv5CyR0rWkM+wiBuy6DCC94HKmuww3DOcIg7KqfdGFH+RkSoLnw=
X-Received: by 2002:a17:906:9946:b0:c4d:939:526b with SMTP id
 a640c23a62f3a-c4d0939530bmr80653766b.0.1793754878307; Tue, 03 Nov 2026
 17:14:38 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023001603.560210-8-wusamuel@google.com> <20261023001603.560210-9-wusamuel@google.com>
 <20261028134012.01d52e94@pumpkin> <CAG2KctpGPHo-S3AEvBhK5HPUnDHfoJu6Z-r+cS1hQ4Ps=B3DmQ@mail.gmail.com>
 <20261030100215.6f8e0d4f@pumpkin>
In-Reply-To: <20261030100215.6f8e0d4f@pumpkin>
From: Samuel Wu <wusamuel@google.com>
Date: Tue, 3 Nov 2026 17:14:26 -0800
X-Gm-Features: AclHuK-cSPxC_sFXLW9VVvDKj-9cMyP8tHQ9MAfu7xEMrtFl6vQvJ8w_LlboHFk
Message-ID: <CAG2KctqdPq6NmK6rB13s2bgM7kP2w4OMMy2hdp_OFMVYYhTnZA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] kallsyms: Add KALLSYMS_QUERY ioctl to /proc/kallsyms
To: David Laight <david.laight.linux@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 3:02=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Thu, 29 Oct 2026 15:05:45 -0700
> Samuel Wu <wusamuel@google.com> wrote:
[...]
> > BY_NAME matches names exactly, like kallsyms_lookup_name(), so they
> > would be different symbols at different addresses. Please correct me
> > if I'm missing something here!
>
> Only that the user might really want one of the copies.
> Sometimes there is only the copy.

Good point. I'll have v3 add KALLSYMS_F_PREFIX + pos/next_pos
pagination to cover these. A prefix query for "foo." also finds the
copies when plain foo does not exist (expanded on this in my reply to
Andrii's Oct 30 mail in this thread).

[...]
> > > Have you tried measuring it with my patches that speed up the kernel
> > > 'search by name' code?
> > > That speeds the lookup by a factor of ~18 (testing the code in usersp=
ace).
> >
> > Not yet. Can you point me to the latest version? Happy to try it out.
>
> I've just forwarded you all the patches.
> (They include patches to the tests and scripts/kallsyms)
> I'll copy you (and the other people getting this email) for v3.

Thanks for forwarding the patches! I'll be looking out for your v3. I
tested them across baseline, baseline + my series, and baseline + my
series + your series, using the same two benchmarks and setups as v2
patchseries:

Loading a BPF program with 11 typeless ksyms via libbpf (8-CPU x86-64
Cuttlefish VM, 273k /proc/kallsyms lines; BY_NAME, unfiltered, so each
query also scans ~35.8k module symbols for ambiguity):
- Base: 156.1 ms
- Base + my v3 series: 2.05 ms
- Base + my v3 series + your v2 series: 1.95 ms

Perfetto symbolizer (8-CPU x86-64 VM, 175k /proc/kallsyms lines;
BY_ADDR; init / 50k cached symbolizations):
- Base: 129.1 ms / 28.0 ms
- Base + my v3 series: 0.04 ms / 3.4 ms
- Base + my v3 series + your v2 series: 0.04 ms / 3.1 ms

I'm seeing your series help most when the vmlinux name search
dominates: on the Cuttlefish VM, a vmlinux-filtered BY_NAME call is
5-7x faster (hit: 8.3 us -> 1.7 us, miss: 9.5 us -> 1.4 us).

[...]
> > > > +     __u64 query_flags;      /* in - query mode (enum kallsyms_que=
ry_flags) */
>
> There is no need for a command here - use the ioctl cmd.

Agreed, done in v3
