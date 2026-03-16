Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C1C37703B
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 23:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773702550; cv=pass; b=apdjaa+iwa5lLSOcOXpD2IyETMk6FtV1HeISExZZ8CwXg0vG1QXb7DMGkC5+2AWqyhGzaa4A+f1wj/fqMfUJETPfivkC4TwD+m/e/zPCpQwVlajsq+emMdyI6ptc4mdWpeTLT7+dLx3S6TvulHxB4ihdTyhCkOQRRyN1QNan3QI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773702550; c=relaxed/simple;
	bh=+cAJ4iIFIxRHig92sYo84qvhIaHp9W4lFkHVoCvc15Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f25ZKpFwiRCODupU65sImbezYWdcymF8oo48s5bYCiZH4Kg0zap4scJh2tiiBt2I0tdtJgcEkCqFf1OrCTnrfg7KDlXUkETEiVuTUO6kJ93oBUhuhfNAwupeAunnXlO9lvBcT3WasE2/HNPhbenPKw16TfqM3v4u69E8U+5wqIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6IntPEf; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6IntPEf"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43b4d734678so10420f8f.1
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 16:09:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773702547; cv=none;
        d=google.com; s=arc-20240605;
        b=iDzmUB9+25/i5Yo8lUCyr2Q2JmjjaTK9tjTUfWTMjd/GrkCWHWCXImLkFuao/OHSB8
         FFHzNCmmmIn0bDVYqwx35m0DXV/BO+kiMsLdl0hFrt0MQLP5eJaAnkDf7TN3A42YxxRI
         q75u0f3aiEYWVHJNCFPyHEIKO+5hYmEUiJl/HAzawRiBCyhHDYLwORY4khxu24u9GEQD
         1n6FxeZ2opCczPaK4Y4Il74Og9bns4pFc+AB4mm0oZ7bMmfjRtLtWyltgJYa69jUHGYd
         00NLlU9ZFaphcQ2O3xScLOUIraO3PhknJW+YNN3fbwi+ff7z+0C+1BXzZvmxLfiHhBF6
         9V9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YTcEvH+GjDpjQFw+Gwl6J2Beep0t2E3u6sg9IRtiNzE=;
        fh=cnjljXC5n9TTLsK5xLfVpxeSjLD2EXeXIxp3Xnee1l8=;
        b=hp8saZFjvTz2y8TZ2bqV1bwnn71bhPrDB4s2efGLZkl/UHS6QTxm7z6JkDcuHPCr+2
         39GodQj30UZQ4tCB4dt2SwAovcjoR0msJpbz+Ey3EfKiT/+Si0Qwl087lS1p7bJpUmBg
         A4mr2OlxzRShEVz12VlhQG2ntVmcimZ1RoOi9Jm+p/zawx7lCtgxA26SGhqAjcpRa2BE
         FRlEHzD6tYWy+mEzUwTB8aaV66lrkYwkkzqf9HhFzR47F91b5Z2RQWGc2/EKnmTmX+2R
         Sss/4u66zoX1gj9YKrBWfGIJ4m8T8v7CH5uy6rDrPDz+8zJ7HjuhqZ+WDoie0+3f7R3G
         OPQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773702547; x=1774307347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTcEvH+GjDpjQFw+Gwl6J2Beep0t2E3u6sg9IRtiNzE=;
        b=D6IntPEfYTZg7kuSqNZ0xwoTJK/di7+wNmv9xTRAPJh5ttY158d3g3/AzB7k89M0UD
         skF+XyXEA6cLESYOW1zdWFQ17weizHtb5Gt5qDukO1DwPh3jyGt7eMU+QbqvginTkvFF
         R6Zp7n1uvzGcSSV385Z0RkxSRU5ReYA9DTbEBnyTkMtqcdveekmreDSIoJ5G0q3XA32v
         U8+2gVKFYZkxke14ocXHcYnVYSpzxP0N57boHVZ0B7z2jlHOmW7va+hBjXqfzkkuW4BF
         qWcfzP5fAK5BJR1zdz9KG+8vghwKFvnyHAGE4aNKdkv+lJSmFC84F/1o3ebPYt/0eHoo
         vGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773702547; x=1774307347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YTcEvH+GjDpjQFw+Gwl6J2Beep0t2E3u6sg9IRtiNzE=;
        b=Y4RqbYUtGCLtq4ZtXnfLyai2BiXEwV1AaEGv/HsR8QMg+pujUo4anI5qrZ5C0lU/0F
         FRpIhMYoykDL9oVmzQ2D0L+eS0fuozoHDSqPOpCv8qcj9P7LeE9HutA58VUq8jx22tUH
         oJoCJfpa0Q9LB2w8LTOJL0jh93zXa4eBWj/NeeRFp5GwEOUbZLLV8LuQI9kiARJtPP0W
         2Kotmusm8iogjYxONc5k6afrKS7RnaeRpVoVn/kU6nS+0MgMftyTnukyvzsv5ibkoDaw
         GsgauqnmDN+4y6hoKCveljeYvvQq1mxftjx4VlxnsoMpu8DfbYCAcdfYaNiasq4TeBSb
         Zp0A==
X-Forwarded-Encrypted: i=1; AJvYcCXxMzuDZ/But7ZkG13y+qRKZD69Ocd7UDgqpn9gXb80N2CT7DPdvKrf5LSdMeQ01HstLAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUQViUOCKZcEWG6Vw0sT8Fj2I3CmVA23NDJU6DYld83UfhJYo8
	8Ve5Kl0p8f1cmeYBGsdxplkh8KSzTt6I1VsnOsz4b9U9excXNlES7U9cBv2FrK2e0tKRPgmTEQf
	1BGF0RqvURP9HQhszLPM5fTUZEDJgT0c=
X-Gm-Gg: ATEYQzwEHvWkfIsPX6FOkQZX60c06N6LXDkcocn+uETpCm1ww/Kio3uL0lPrpkEdCJY
	l3WZCqQNg/t4Dn+0Mugk9nUFclHqLwFElNMrIdIogoaa3t/SsdD+8GD655F2yYeGRc+9MFqpep/
	OQ3q5KkUQvG7WtrP3cSIOA3z6L0Ubx/v2QVPETkQUrTcPl1dvNy67ELh68qT4H2OI1MFsB0MFEZ
	D8M9jFEd2zTlnhNRPcjwKgHdakrRfU1OzI4ve98hoP8vZQ3duCygaYbRoYtC85IvdjZyCDhTufE
	v5L27A==
X-Received: by 2002:a5d:5f83:0:b0:439:b8b2:fad0 with SMTP id
 ffacd0b85a97d-43a04d83ff6mr28400817f8f.5.1773702546587; Mon, 16 Mar 2026
 16:09:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223224617.GA2390314@frogsfrogsfrogs> <CAJnrk1Yd1J60-Ek=O7jzZQg454pbr3O=b71yZHzYbrWfqJr__w@mail.gmail.com>
 <20260316180408.GN6069@frogsfrogsfrogs>
In-Reply-To: <20260316180408.GN6069@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 16 Mar 2026 16:08:55 -0700
X-Gm-Features: AaiRm53xx1udDBBozm1YmDs3kuURdsgNVNQ8IfBAmck4rGWxaKobRoPlK5vEPvg
Message-ID: <CAJnrk1bmJYMt27xedN2Xza0KPXfYEbh-9g=3fNWru-HRM9WFEw@mail.gmail.com>
Subject: Re: [PATCHBLIZZARD v7] fuse/libfuse/e2fsprogs: containerize ext4 for
 safer operation
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, bpf@vger.kernel.org, 
	linux-ext4 <linux-ext4@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Bernd Schubert <bernd@bsbernd.com>, "Theodore Ts'o" <tytso@mit.edu>, Neal Gompa <neal@gompa.dev>, 
	Amir Goldstein <amir73il@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, John@groves.net, demiobenour@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 11:04=E2=80=AFAM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> On Mon, Mar 16, 2026 at 10:56:21AM -0700, Joanne Koong wrote:
> > On Mon, Feb 23, 2026 at 2:46=E2=80=AFPM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > There are some warts remaining:
> > >
> > > a. I would like to continue the discussion about how the design revie=
w
> > >    of this code should be structured, and how might I go about creati=
ng
> > >    new userspace filesystem servers -- lightweight new ones based off
> > >    the existing userspace tools?  Or by merging lklfuse?
> >
> > What do you mean by "merging lklfuse"?
>
> Merging the lklfuse project into upstream Linux, which involves running
> the whole kit and caboodle through our review process, and then fixing

Gotcha, so it would basically be having to port this arch/lkl
directory [1] into the linux tree

> user-mode-linux to work anywhere other than x86.

Are lklfuse and user-mode-linux (UML) two separate things or is
lklfuse dependent on user-mode-linux?

>
> > Could you explain what the limitations of lklfuse are compared to the
> > fuse iomap approach in this patchset?
>
> The ones I know about are:
>
> 1> There's no support for vmapped kernel memory in UML mode, so anyone
> who requires a large contiguous memory buffer cannot assemble them out
> of "physical" pages.  This has been a stumbling block for XFS in the
> past.
>
> 2> LKLFUSE still uses the classic fuse IO paths, which means that at
> best you can directio the IO through the lklfuse kernel.  At worst you
> have to use the pagecache inside the lklfuse kernel, which is very
> wasteful.

For the security / isolation use cases you've described, is
near-native performance a hard requirement? As I understand it, the
main use cases of this will be for mounting untrusted disk images and
CI/filesystem testing, or are there broader use cases beyond this?

>
> 3> lklfuse hasn't been updated since 6.6.

Gotcha. So if I'm understanding it correctly, the pros/cons come down to:
lklfuse pros:
- (arguably) easier setup cost. once it's setup (assuming it's
possible to add support for the vmapped kernel memory thing you
mentioned above), it'll automatically work for every filesystem vs.
having to implement a fuse-iomap server for every filesystem
- easier to maintain vs. having to maintain each filesystem's
userspace server implementation

lklfuse cons:
- worse (not sure by how much) performance
- once it's merged into the kernel, we can't choose to not
maintain/support it in the future

Am I understanding this correctly?

In my opinion, if near-native performance is not a hard requirement,
it seems like less pain overall to go with lklfuse. lklfuse seems a
lot easier to maintain and I'm not sure if some complexities like
btrfs's copy-on-write could be handled properly with fuse-iomap.

What are your thoughts on this?

Thanks,
Joanne

[1] https://github.com/lkl/linux/tree/master/arch/lkl

>
> --D
>
> > Thanks,
> > Joanne
> >
> > >
> > > b. ext4 doesn't support out of place writes so I don't know if that
> > >    actually works correctly.
> > >
> > > c. fuse2fs doesn't support the ext4 journal.  Urk.
> > >
> > > d. There's a VERY large quantity of fuse2fs improvements that need to=
 be
> > >    applied before we get to the fuse-iomap parts.  I'm not sending th=
ese
> > >    (or the fstests changes) to keep the size of the patchbomb at
> > >    "unreasonably large". :P  As a result, the fstests and e2fsprogs
> > >    postings are very targeted.
> > >
> > > e. I've dropped the fstests part of the patchbomb because v6 was just
> > >    way too long.
> > >
> > > I would like to get the main parts of this submission reviewed for 7.=
1
> > > now that this has been collecting comments and tweaks in non-rfc stat=
us
> > > for 3.5 months.
> > >
> > > Kernel:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/=
log/?h=3Dfuse-iomap-bpf
> > >
> > > libfuse:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/libfuse.git/lo=
g/?h=3Dfuse-iomap-bpf
> > >
> > > e2fsprogs:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/e2fsprogs.git/=
log/?h=3Dfuse-iomap-bpf
> > >
> > > fstests:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfstests-dev.g=
it/log/?h=3Dfuse2fs
> > >
> > > --Darrick
