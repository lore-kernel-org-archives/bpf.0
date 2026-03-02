Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEE93148A7
	for <bpf@vger.kernel.org>; Mon,  2 Mar 2026 17:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772473081; cv=pass; b=GVEFvnhBjw4UDWK9KNz792L8HmW0EV0FzOWu2spkJqMXJQqhv82GJh0A6Vkyir9PUBSNysUYZ69s5buCeIr90cXeY7iDYyVejBysUSCtzclnDh33iNmQDdfWIJW2mNJEf2XJaIqY2Vffhztxbi9BEq0KKCdN60DW30c1/VBV/uU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772473081; c=relaxed/simple;
	bh=QJ/PP+T0AGjAqo1m3nscVXD2bzphurhakxxs1FcbDFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wc0h6Ag2YILemJiDQFbJX0GfNQdRhF6GWT9utVki0nzO/fzweTViLNaLPfXO+4tNjpVKQCZKJvxt/djLEd1B+oUNna4i4uK+UEoYIINEg1J7K+1jYsXkgdunVv4nhBbhLJoxn47O0aHiU5EYejdwXUXBD9zTmt/nWu1H6GlsRPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=TZVLYdkD; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=nWgT8mQV; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="TZVLYdkD";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="nWgT8mQV"
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622EsPJ1542577
	for <bpf@vger.kernel.org>; Mon, 2 Mar 2026 17:37:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=IbAqDSv61OaxUm1HXMGYPokY8UuDzdZ8xwsXQb7ylvI=; b=TZVL
	YdkDf2+cj+tii7kwO15XIv7LRLBql4BNqf20meaDGPMdGW272TnnJJrCfdrZJa3Q
	xMOPJTwVicMAe/Zql0Rz9Yo4jMPOgyQCB1izdWTyPuhD6ImIT39Kd4WNaICV7q82
	PPUJY2E4LZMHSj0C2Ij11U6Km+9Dj6xPAKXLBatke6IVUBfBwzwFj7cHZEqRaJ+Q
	eqRqPY8HpGrRIT4CiCQryOJlMS3/FIymqbbLAojhVqiI+tX6ipkK0F6GdO+wxf2v
	7T0ivR2p88OhC3yn6IgIcElpsmgOsqDkpU+kSkzAwR8Wk4imdT4a0jm9O0SgceOz
	ziU7/9AwVLVBlHttkA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4cmbkwdfec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 02 Mar 2026 17:37:53 +0000 (GMT)
Received: from 04WPEXCH009.crowdstrike.sys (10.100.11.79) by
 04WPEXCH014.crowdstrike.sys (10.100.11.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 2 Mar 2026 17:37:52 +0000
Received: from mail-yw1-f199.google.com (10.100.11.78) by
 04WPEXCH009.crowdstrike.sys (10.100.11.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 2 Mar 2026 17:37:52 +0000
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-794b74a8b2bso58436207b3.3
        for <bpf@vger.kernel.org>; Mon, 02 Mar 2026 09:37:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772473071; cv=none;
        d=google.com; s=arc-20240605;
        b=lmQLcCOPlqovckuwC1A0Lujbfhh3UUVisuUkrJC04PF8rmtJtMEY4EHljXj6zr1Jwm
         mFQ/WmJ8sU82ii7JPVApyipixJAhqAWNl5uiOTzoj9S1R2mc7N/Wlqj+BIYRA5GKmuqL
         DVkpXR/ThIAV5RkOu9N6sXSujGHxxB/usy0suDK754O7FfCEuNkQqGvMKZ7ChmBG9fo8
         K/0oZ+9IvczgWPk2fcfH+xOooE7MPsp5bAwRsCFAqgTGcdFqXydI063XFjEimD+wP/LW
         4+ew/PLfeAEIg1L2lIzzyp9EcnW5ATuLSRPduOyBcRSP2OJuC0oTidC+QeBxV2z2fFEp
         +FSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IbAqDSv61OaxUm1HXMGYPokY8UuDzdZ8xwsXQb7ylvI=;
        fh=7xasTfHfbCbrYnHh88Shab+OtmoyhYEmY1+u6ZgOUYE=;
        b=B9hbBD0KZUHrD0OPPXivrCUQPXHDBiCiodqR0Ya2bc73afcu6oJjroyb0u6H1vLYn8
         W+h20dV06Zkfzvf5N24QoVb2LYmYM3J41DWev05GjMIUTaWjS6iGAGiE5Dk0ZiBarh3O
         oafjwOIhf0bsqTq/dIJyRKO33GLjply2YkyNiEP5g3T3L/q2p7x9IWo8hEuZBZhtmlZl
         4xys7T0uOSdpFbdblaLOSCefvSIIhLc4HDATzOlaA2ZKz7XbBisd9Ah/kCPo7zsvZO0S
         LNxj9mFhQDpCHDiC45JGYVxQ9w8KpTVRltkHYQsKhd5zfHVXoyurCGSuw9BLn8h+S+aj
         Utbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1772473071; x=1773077871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbAqDSv61OaxUm1HXMGYPokY8UuDzdZ8xwsXQb7ylvI=;
        b=nWgT8mQVaZ8bxwVyGUWTpWnAlWu2yXdfWselUpl80WxT/+3PJcVBxIscYLwuSMW49c
         JHCaisckiTFXweGHHdMCZkZrzIIxnTH8X/b9XBNJ/uDZtP+0uszaPzIejCngI7niBGSf
         ofwIDO/de3YRsvfaASxGBnWsAdacncfaxi+kXHI/fncReXoK1M9jr5ohtuTYjHNFzbLq
         xQ7ttvWRKUcFPCduRenNp8mOrDtPq3uQzEiuG9Hpz0J7IdjhdYdWl0TISC0coza6mn+2
         VqYxRi7zweAEmO21FhkLqWOTpzPngKs89Ub18qd7cd1caxYX+zs3rjJGmnURLga1K75G
         POOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772473071; x=1773077871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IbAqDSv61OaxUm1HXMGYPokY8UuDzdZ8xwsXQb7ylvI=;
        b=ffgUfVS8eQ02ZnHPhz+8AvnVJPocb+spFlaFjV4kQzPNq9OIIhlttV9rel6SXy0fsZ
         DPOSuTq1gPKDd/eXUSLTDs/uz0JQ1nCFL5/eEG1sSmGNOIH/tAWd2cqLtBckkzjEmvEh
         C0ZprxHvLh9OeCGLg02jquHjOa2yVUUCBsmQh7RmJuP2BukEHy4MuoPB2yU/LbNDqBtV
         H4VLmjX14XrTPLvoQc3gzz79qW4O031Sj5DHU5XZF1P4UIgr23b7jNGhcqXG0I8EJ+B5
         EiNs+oRI1rAMFKSyn1qgszLp490XREWj2F0/BYv+5TstrPm3JCpdzjlWHTzCkWj7mXwo
         q4+g==
X-Forwarded-Encrypted: i=1; AJvYcCUHWhFBLOG7+4kXzCMC+VgHWHpynX0hX2AI6LnEK2uADI0K3miXK+g7z0YCxrJHFjzcJzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqLMNV0zyPi5AMWz3HaoSBSJM0GO6vFHpdZnKjXBw42/eSULKU
	hVWcBAZiLRRhfH9HvpWNq8EFMJaAyAmGcq0gfT3DEQ7OHAqSSSxQCqPO5KcO2cprQRZbfIXRk/P
	G21cDz+EC0y6CHgC6J4+139Xif+4My7WtqpawjSIjSaM77bOLtPDVndxHevMDsWHs8fVKxaKjQM
	7dc9bia71aCAGpJqHoQI5iCgqVkuNYJyT9lq2hyO6a21Y=
X-Gm-Gg: ATEYQzyPiAKd0T7oE3jW3+GZ8wjuTeYBAeJuLjSuuQDT98bHuMgPJu7AZUKhg8YQQP1
	twvXoShNxJ8HbtrS++drxVa9kdtlOFl50UkqjwQww9p0vRzuAWRQfIdU6rXykpfCGmwvQC3WYTI
	GX578f4aJZtkuKSLnUUqIu44LVOg5EnmEXYdOIV+7oecUYpOf+r6r4KKSZqq7pvZTCkM4mVn/5m
	Q0t
X-Received: by 2002:a05:690c:10c:b0:798:6c28:dd68 with SMTP id 00721157ae682-798855c155bmr122475247b3.54.1772473071573;
        Mon, 02 Mar 2026 09:37:51 -0800 (PST)
X-Received: by 2002:a05:690c:10c:b0:798:6c28:dd68 with SMTP id
 00721157ae682-798855c155bmr122474807b3.54.1772473070960; Mon, 02 Mar 2026
 09:37:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227204052.725813-2-andrey.grodzovsky@crowdstrike.com>
 <2d0e9de12b7bf49a0b5117da6d305b0e918785818b63798dfd85de1635b68e8b@mail.kernel.org>
 <CAOu3gNgRpMd9poZYibhGg+UfQXiHpB3ucnhvghoT0TF1rFfmPQ@mail.gmail.com> <aaVtarHiOYPfe9Tu@krava>
In-Reply-To: <aaVtarHiOYPfe9Tu@krava>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Mon, 2 Mar 2026 12:37:40 -0500
X-Gm-Features: AaiRm50k8g-QJNyM5_HOsKYr3OetDVBYPg0kvJqT6keqfNnNaP0bQu_yTa6bKMA
Message-ID: <CAOu3gNjPX_vf=5anZ-fhqR5S+P3uaqur3oc1T3yLqMs3anGHrA@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH bpf-next v3 1/3] libbpf: Optimize
 kprobe.session attachment for exact function names
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bot+bpf-ci@kernel.org, yonghong.song@linux.dev, bpf@vger.kernel.org,
        linux-open-source@crowdstrike.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, rostedt@goodmis.org,
        linux-trace-kernel@vger.kernel.org, martin.lau@kernel.org,
        eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Disclaimer: USA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE0MiBTYWx0ZWRfXx4cOPeoett0m
 0Gna8Ct5+3Lyaed80C9JFX1NZ2IV8GNZLJz30u0JJANvE3U+hHG6dmyV2wJ4dGyeNCcAir+NFlO
 JLha4AdxGzcmWY3OHa0wFiWu5W23ohawOMQ6yUO4Qv4FVDD1fm3bOStkmt/0ROlE3alkf6JKJC6
 4adNcdHugSDS/+V9f2QYuc/+SzGTmRv0/fZiKRueexqsPioHCq7Fnw8Qq52LoYTxZvUMd8dJCYO
 ynKunP3sUhogkwt7D8VgRmWdvS+fnwHrQgiyHUYK+8S0RumotE7eQ8uAUIELlku0w836p50RrN1
 05KLFJ6Ts7u94oF6F8OOlRcwBPzTRIjc/d6QPN999FrLtGijYXWqG5ig9zYB7AVd0McgOlVPqD8
 6x4NBh1PRreHKrRNIY+dqKvEdB9rJ/J06a4OOSAAEZjbmD+mti0jgxTaO1tb5h9h+2coYSMspCC
 v4A+q9BEeto7Sm8g5kQ==
X-Authority-Analysis: v=2.4 cv=M4RA6iws c=1 sm=1 tr=0 ts=69a5caf1 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=KZhmPCYDdY0A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22 a=b3B37AjAgz0HnGB3MuNd:22
 a=VwQbUJbxAAAA:8 a=iFABrAoMAAAA:20 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8
 a=6aJR2x0Un_piba_x_FIA:9 a=QEXdDO2ut3YA:10 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: Y0QRFGtNoi8rHl9_5ROCOBgThVXn_NL2
X-Proofpoint-ORIG-GUID: Y0QRFGtNoi8rHl9_5ROCOBgThVXn_NL2
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11717
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020142

On Mon, Mar 2, 2026 at 5:58=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Fri, Feb 27, 2026 at 05:28:05PM -0500, Andrey Grodzovsky wrote:
> > On Fri, Feb 27, 2026 at 4:18=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
> > >
> > > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > > --- a/tools/lib/bpf/libbpf.c
> > > > +++ b/tools/lib/bpf/libbpf.c
> > > > @@ -12041,7 +12041,15 @@ struct kprobe_multi_resolve res =3D {
> > > >       if (addrs && syms)
> > > >               return libbpf_err_ptr(-EINVAL);
> > > >
> > > > -     if (pattern) {
> > > > +     /*
> > > > +      * Exact function name (no wildcards): bypass kallsyms parsin=
g
> > > > +      * and pass the symbol directly to the kernel via syms[] arra=
y.
> > > > +      * The kernel's ftrace_lookup_symbols() resolves it efficient=
ly.
> > > > +      */
> > > > +     if (pattern && !strpbrk(pattern, "*?")) {
> > > > +             syms =3D &pattern;
> > > > +             cnt =3D 1;
> > > > +     } else if (pattern) {
> > >
> > > When the fast path is taken here, unique_match is never checked.
> > > The unique_match validation is inside the "else if (pattern)"
> > > branch:
> > >
> > >     if (unique_match && res.cnt !=3D 1) {
> > >         pr_warn("prog '%s': failed to find a unique match ...");
> > >         err =3D -EINVAL;
> > >         goto error;
> > >     }
> > >
> > > Before this change, a caller passing an exact function name with
> > > unique_match =3D true would go through kallsyms parsing, which could
> > > find multiple addresses for same-named static functions across
> > > different translation units, and the unique_match check would
> > > correctly return an error.
> > >
> > > With the fast path, the name goes directly to the kernel's
> > > ftrace_lookup_symbols(), which resolves only the first match via
> > > kallsyms_callback() skipping duplicates:
> > >
> > >     if (args->addrs[idx])
> > >         return 0;
> > >
> > > Should the fast path condition also check unique_match, for
> > > example:
> > >
> > >     if (pattern && !strpbrk(pattern, "*?") && !unique_match) {
> > >
> > > This would preserve the optimization for the common case while
> > > falling back to the slow path when unique_match is explicitly
> > > requested.
> > >
> >
> > I am not sure this makes sense, according to the original patchset [1]
> > this flag was specifically tailored for patterns with wildcards where
> > this indeed
> > makes sense. in our case, cnt =3D=3D 1 from the get go since no wildcar=
ds so this
> > check can't ever fail.
>
> I think the problem is that it could now pass for cases where
> function name has multiple instances in kallsyms .. while before
> it would be caught in libbpf_available_kallsyms_parse and fail
>
> jirka

Got you, you (and CI BOT originally) proposed  with the unique_match guard:
fall back to slow path, preserving old behavior for this case.

Wiil do.

Andrey

>
>
> >
> > Andrii, Yonghong - any suggestions ?
> >
> > [1] - https://urldefense.com/v3/__https://lore.kernel.org/bpf/202412182=
25246.3170300-1-yonghong.song@linux.dev/__;!!BmdzS3_lV9HdKG8!xk626jLDdORTgQ=
machiRbRK_5oayjcFYNRm-SQS9q7EujjYI3PbN1x1jUehjPM_wsz6h8r0p9z39vc_VotgANU2nr=
_H3$
> >
> > Andrey
> >
> >
> > > > [ ... ]
> > >
> > >
> > > ---
> > > AI reviewed your patch. Please fix the bug or email reply why it's no=
t a bug.
> > > See: https://urldefense.com/v3/__https://github.com/kernel-patches/vm=
test/blob/master/ci/claude/README.md__;!!BmdzS3_lV9HdKG8!z-aIXCz8YRZcraMmGI=
2bmb4YrDgW0brRTcX_BaJCWYwj7xfmkZL6qka6aqqIwzDPUjR1TxUU-Mc50s9AAYQf-vQMuPuGl=
VKW$
> > >
> > > CI run summary: https://urldefense.com/v3/__https://github.com/kernel=
-patches/bpf/actions/runs/22503275616__;!!BmdzS3_lV9HdKG8!z-aIXCz8YRZcraMmG=
I2bmb4YrDgW0brRTcX_BaJCWYwj7xfmkZL6qka6aqqIwzDPUjR1TxUU-Mc50s9AAYQf-vQMuGee=
kJPd$
> > >
> > > AI-authorship-score: medium
> > > AI-authorship-explanation: Comments are unusually verbose for a simpl=
e optimization, and the commit message is well-structured with distinct sec=
tions, but the iterative v1-v3 refinement following reviewer feedback is ty=
pical of human development.
> > > issues-found: 1
> > > issue-severity-score: low
> > > issue-severity-explanation: The fast path bypasses the unique_match c=
heck, which could silently attach to the wrong function among same-named st=
atics, but requires the uncommon combination of unique_match=3Dtrue with an=
 exact name matching multiple kernel functions.
