Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC93E33032B
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 20:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771963781; cv=pass; b=IxF/p9iu6pkulfMsegIS6ouv+eKIZo+n+2of7jiHX1vbTwtUtLGMnGm0Na/z8FBnnwqze0dXdPtl/+2x9rUvn8B4GDYo5O6uIDWvXaV21tsMjL47ItOvkBU/W+P3V2TBw/31cspJtIdT7WwSZy0mN8NgGNkpbw3vPIiJm7vXbBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771963781; c=relaxed/simple;
	bh=2Cg/DXUaQemdS7si661sB6VqKVJNE0PpNQT4QAW402w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y3YPXy7sB35cpNXvss1BqOQhilN4/mZlOJRW5x7KQJ/taNlkzu96GiQe/ZQH06+sgEm8Fra1QUGsgcdooagC+mC/j1yQ9S53MjBTqTyvtszbpuYmIfBkCjuo9GxWHGkJSV/5LZ+kncjR6SZi8DhYyDQunT0xwE/xaj08a8wO/Y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJcaled3; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJcaled3"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50697d6a69cso32859381cf.2
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 12:09:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771963779; cv=none;
        d=google.com; s=arc-20240605;
        b=TteAB6OpxPUWF7445z7bytJ6HP/CikuZkWKBsrOSLKnii5zN2awwuPg8b71/rZziJ8
         rtVXS7YJiJqzJ1+2NmcD9HYPRO2+jFF+D3aIlI+R+XVPeVaH41oaTplIxJc3yhICDPm3
         xBJ97/2XweXIy+m8t3lhrbaj596V7J7lXPjFwG0IV54eoBNkRG1H2q/npNld2L6COT/0
         sALQsXh2GTBRdEOlO6SgC1RTZJb6IiBEgjA1G5XRHB3Fuac3vkSnidOutXvP9eij24jy
         aX8xMWw9PUMbPMvKOFpUUbXpInhwc39lEpaxynlHDbPnLb+N0C+6kMBjyYPFmlkfrx8f
         hOCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1DDHaOfhOlTVmBPRd/vHmXNqCBjvhgIixRlqQfkjm7g=;
        fh=dVamNQeqQBTkGx4i0rqW4pHruYVaTKAxIWUAm65Dvns=;
        b=RSKNgPwuWmG40Vqg6c4Lf0kPuhjnoZW4WI4dShEW+y+gh5z7sTeNMiria+aCifkpqW
         JnjmenRCtGMWedNsfj0toFSy3c1usnItcjQb9Q9oeH68QHn/5ESzOg7MxqVmmYAwZVaH
         7UPnBsyOEUUjP/ijLUuXpmwO262a3BCQVrESL8+qyC6lBF3gFGGMwfxD/vwAKpjFwYc6
         03f0iSk6nfxvZy5ys94HPkN1sOlxHjJ2R0G/Yvn1XpMNp/z92YQvRO4cVP0OEWy9u9/2
         Oq+nkK4zEXGZRKGOXzLMQJ1BtnzeWft4Z62Z+6rfiIclnNhhNJBMYJcQ3rNf27S59/Lp
         sYPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771963779; x=1772568579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DDHaOfhOlTVmBPRd/vHmXNqCBjvhgIixRlqQfkjm7g=;
        b=WJcaled3m4rBPyjQcD4YEGhqpMqXciFvxDGDqawJnXTo3PBfC4cw1nBi4+ors4LGz9
         aG0KN5kh9om+TTrTXXFwzDQMGjKIKgBItoEpOQ6c+VxTiS1pBfDZl79MTOYsVBuhEqub
         +Eoz1MvlXYTJFjP7a/rGvujL+ch/6wd/+kZ1YjUPlN7aySKajKYlkZScS28tEZifgG0v
         3cH1dwFvEYjQyn+jHiXRO6DgsQCjIFKWMvyhlDvY4iuXinDF374LYfwTQHctFEHLJ0jw
         RK2SmLpLnmRONJ7JyQYfpmPJuKbaLBpLNzphejagMtsuv4pf+Q7j3u3vwFhpHW7E2E0l
         GkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771963779; x=1772568579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1DDHaOfhOlTVmBPRd/vHmXNqCBjvhgIixRlqQfkjm7g=;
        b=ibzO3KB2EsiCSaApdLeMXOW/kGYNjwFZJX/lF4R9YY4pOKpyoUHBbF+WygBiddZLVY
         /tVl1W1a5qiIPKfGzYTAzplixTp4DTOrp+R7R8j4B+07v+2MNV+lF5NMOOQXcLrl71mw
         cYUjtzXM28Q3JKVMI/oqzCxvUDQejXhX0n+q+yMSVziKlVmsYPj1AqwecnEXZGUuRfrf
         DY+llTofMtE/jJrL3QTahqfY5RkXvaqefdnVgHsqvarJKkLFtWiLlGxhRENDechGbP9U
         KR9RQehnLJj/uvmShLsSU69itFCz9azOvAC+1dYOY96myu3ObFv3HzD+KEwHynV1a1G1
         1gAw==
X-Forwarded-Encrypted: i=1; AJvYcCWSmKeUYjBEA2n3Hu3SGTopsz715RJoaM+kDfTMJc/Io26NEsUob5kqavd0qnucE7xKgMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjmZB4dcBMvMmZ1p4C/aypCKjrcyFbT7oy1rVDQ0EnzzhWEHbP
	IxXXPiLytlwU6kMEL6AnQY6Gj/bZlQ208mlZ57PKFMI846cD80YZNNDQ2oc0CWePLlnIuOf6EGw
	YcWZG39Heq3y0CSHzcR0TumFgjhz8kro=
X-Gm-Gg: AZuq6aIt02RoS7x4zDeNl514/74ABCIboo7y/RCvEnm4ruVdcd2QLDKYlodXNPit78d
	q8gcJeni9XgaO6WBq4wv5mk6aMVTDf9GEq384ehm98i1/LJ7YPveOjlrdXMnQ6EJDBnyI/rfpub
	rdIMmVLOp+ZwmYzCoYO1sQBM0nnwKupbb78F583pvS/zajH1DQbm0rzbh5gyHj4IkdfyHe5cv1Y
	NfYUkXdShQ1BWPv5se1hrmNSd3YcMJdsbzlG9aksJiy3B+aDNXHBuyOxPMOvk4CH/Xi6maHZIJG
	wYCE+A==
X-Received: by 2002:ac8:5a05:0:b0:503:2d06:8e15 with SMTP id
 d75a77b69052e-5070bbd5fbbmr189408691cf.21.1771963778577; Tue, 24 Feb 2026
 12:09:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177188733084.3935219.10400570136529869673.stgit@frogsfrogsfrogs> <177188733154.3935219.17731267668265272256.stgit@frogsfrogsfrogs>
In-Reply-To: <177188733154.3935219.17731267668265272256.stgit@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 24 Feb 2026 12:09:27 -0800
X-Gm-Features: AaiRm51mgRlWbkXb6u9q8vdEfIKt7UeLJ2adO4XjFSbDCtDEImXRc2B_2FbsvY4
Message-ID: <CAJnrk1bEm=pe2M367CsbQNYyUEdXCVzAyboqqHnSCxx7fxZKZA@mail.gmail.com>
Subject: Re: [PATCH 2/5] fuse: quiet down complaints in fuse_conn_limit_write
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, stable@vger.kernel.org, bpf@vger.kernel.org, 
	bernd@bsbernd.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org, 
	linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 3:06=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> gcc 15 complains about an uninitialized variable val that is passed by
> reference into fuse_conn_limit_write:
>
>  control.c: In function =E2=80=98fuse_conn_congestion_threshold_write=E2=
=80=99:
>  include/asm-generic/rwonce.h:55:37: warning: =E2=80=98val=E2=80=99 may b=
e used uninitialized [-Wmaybe-uninitialized]
>     55 |         *(volatile typeof(x) *)&(x) =3D (val);                  =
          \
>        |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
>  include/asm-generic/rwonce.h:61:9: note: in expansion of macro =E2=80=98=
__WRITE_ONCE=E2=80=99
>     61 |         __WRITE_ONCE(x, val);                                   =
        \
>        |         ^~~~~~~~~~~~
>  control.c:178:9: note: in expansion of macro =E2=80=98WRITE_ONCE=E2=80=
=99
>    178 |         WRITE_ONCE(fc->congestion_threshold, val);
>        |         ^~~~~~~~~~
>  control.c:166:18: note: =E2=80=98val=E2=80=99 was declared here
>    166 |         unsigned val;
>        |                  ^~~
>
> Unfortunately there's enough macro spew involved in kstrtoul_from_user
> that I think gcc gives up on its analysis and sprays the above warning.
> AFAICT it's not actually a bug, but we could just zero-initialize the
> variable to enable using -Wmaybe-uninitialized to find real problems.
>
> Previously we would use some weird uninitialized_var annotation to quiet
> down the warnings, so clearly this code has been like this for quite
> some time.
>
> Cc: <stable@vger.kernel.org> # v5.9
> Fixes: 3f649ab728cda8 ("treewide: Remove uninitialized_var() usage")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

Makes sense to me.

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/control.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
>
> diff --git a/fs/fuse/control.c b/fs/fuse/control.c
> index 140bd5730d9984..073c2d8e4dfc7c 100644
> --- a/fs/fuse/control.c
> +++ b/fs/fuse/control.c
> @@ -121,7 +121,7 @@ static ssize_t fuse_conn_max_background_write(struct =
file *file,
>                                               const char __user *buf,
>                                               size_t count, loff_t *ppos)
>  {
> -       unsigned val;
> +       unsigned val =3D 0;
>         ssize_t ret;
>
>         ret =3D fuse_conn_limit_write(file, buf, count, ppos, &val,
> @@ -163,7 +163,7 @@ static ssize_t fuse_conn_congestion_threshold_write(s=
truct file *file,
>                                                     const char __user *bu=
f,
>                                                     size_t count, loff_t =
*ppos)
>  {
> -       unsigned val;
> +       unsigned val =3D 0;
>         struct fuse_conn *fc;
>         ssize_t ret;
>
>
