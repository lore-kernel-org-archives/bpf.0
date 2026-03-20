Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404D0387347
	for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 17:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774026285; cv=pass; b=bsF5xLGjN1XUj2rMukrxwSaz5EITFX86p72FcB+AqSVrKsm8SI5PLopXeKEoLAF/4v/DWB6VRzTnwgXnhgfGzVkS8cgen/j3ez4gxO8+y5P+fi/6GY0Dfyn2x3N57yiOiqvf0JVeGX5CDFMojTvdMh4/A1WwFYxF9JsCOMDGjrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774026285; c=relaxed/simple;
	bh=+bl/uBIhPNqydKIdxjAkvggAJ7Krl++MR0iJh/EZ/d0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t70VTKvJuVz4vClxGbLcrzZOUdGKoIEi5Tb+4y/bnGi2ZgE0AOvWp37dYHIJB22TX/5rfBgGhn5ncpfH7p8Matx3Cvn70t/McP8VLQy4dfWgjemN1GMiR3eiVUGLjgF+fGTjWm2oR0M4P8+lkwIZ4a/BcZb9b8fvEB1cYe/3jdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgIAkprp; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgIAkprp"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso18054015e9.3
        for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 10:04:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774026281; cv=none;
        d=google.com; s=arc-20240605;
        b=biNxyzHzcIOKGJGL3/KCA6Fbb5+OCqKedLgHEO/pt2b29cofREep3nW2/QwwPORbbT
         oQ55aIeNpd41fvYnY5IxHuDkKNrpAwPMvd+8/X8f3HnhXKlrdCattdVFxCjnoaDUaVdc
         /24aruOKQxT/WMUOgFFbeO/Jpk8z+Ajec8lPwvldOnxDFMbsUfOBWdVA9ewuL3ikNCFA
         6IFI9D0BQI/vpcKCFwRtmOebr5AbCferkMewDkkK9rS9nLO31PgBdfOtnTVi5M4vaNTi
         ONE5YlFud2Lpi/eJYTDXKDCQuXNJqgYRhD0uL0THtUONHcmC6x4CtRjVP+1IKylskFZf
         fDAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I9IRcCyUSKVtsIJtcaSlKi8SABJOeRMy8z1xpU+5O18=;
        fh=C0WLaaCXKGeh/vyFX80RUhue9ehfZ3Zab3MRjKhKV7U=;
        b=h3fAEVCRlK2EVJDN5CRMbbqDZgOIZJZvhZBz+IUyhjDhZFuM3AJyUvh6ZLdVv3rXKN
         uQF0xczsgdhnASuRb4ZCYQhhG4r/+vqYLCIez7uyrQ/lb6RzL/jTcc6QJ2WsONQN0QtT
         ZeIwgNHBv/uZtjEBQZQ5oV6+kp2JNvw47c00uLjHWaWDY5mWdlgqmlAPxfNL1PiBndlP
         zmpoqUy2II5/PErxmh7SpR18NV0DndfLjEy2qSrllMd3SD6tNKKOKmvRK9DD/HcpeC+N
         vcp4x+MgoPDF+zFgBw6h4K+IL70B4tNIWQ82tWXWRY2ix3PfXoBWiaVmzbvJ2mgtHGJC
         OBOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774026281; x=1774631081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9IRcCyUSKVtsIJtcaSlKi8SABJOeRMy8z1xpU+5O18=;
        b=RgIAkprpZ1iZ6gM9mY4c4hCczKoTjJp2v+qQp4SB2V6+ltVels7ljFKYS8g9lp3BtI
         NWtUA7aOcQqo6eZIGAmGujlsliUbdvVWlroIkQF1Hg/4BphDnypa6cxiP5uUzHy1zZ2i
         D0motFDdpeWGG8gWpvchJV/YKgZXpVI2K+8tcfz/HpGMXpv5eDE1wV+WsHyh8nEnZcxT
         2U+aDmcfQ5TIAqx2LmcCL0ii5dHH7bRTXPwST4sN+KXFUuJrpC7q6m45cXCPylzsjA19
         raDP1Y6fEueuaMs/rWyHVQhYINg4Dh6ItBVQDhUO/giyqUqABUXVxn3vTSfhCQDhUXPy
         yHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774026281; x=1774631081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I9IRcCyUSKVtsIJtcaSlKi8SABJOeRMy8z1xpU+5O18=;
        b=IIIYVloyyDuDG2sDya0wa0WvIA3wlrpZG/l4EvVmzO8gHEyp4IiSYYOSWKC9YEgRel
         1rSFi7tINbaZud4BCIHOEGm9aOss133tFjSA96HvJAiz66G8uw0yc8WWEDxH/HqfCXSb
         RGDbj+gRZMY9ZMCodKCijOimwGOil2xdd3AOnx37DP6pVRGFLd5bnh2weqgfZEIFErWf
         5QeZMNTHxcIpRQT3GT9LPJVwfw4qLSj93FDLEVl/WFJM2ITxderbgf56in01K/lNoZOA
         XhLun4Mf26QhWiCr36uoeTyLgU97QMh8BnLmbqauMCyPFxR8Bmt+fv9vjyzxsnWhB/y1
         hg6g==
X-Forwarded-Encrypted: i=1; AJvYcCWoMUFDhUnz3npol/spyikiWJ+NrJm8Lu/sUqeOzk+/S3LMVzL9K3L3kQR2YsS1F53Y4uc=@vger.kernel.org
X-Gm-Message-State: AOJu0YybxAJT/q0puG+pSedFjHsDUAI2TxSD7YVuMJmYK9fhiIBWds/z
	Mv4vC6R/5DOhryfXFO4cj9t07d4vuHizqF6aHGShMXZKxjtBVBJFfJQlT8ykMf+PEk1t26Mh38R
	8qI2+O2HgtdKN4ULu5mqDu8rCq1s+MwQ=
X-Gm-Gg: ATEYQzx9DKhQwJSylYPn+2YKl/wJf3jbdshJ2NuASlRtUaUkVI2RoknndcU0tCg/Ic3
	MOe/JfaWPVqZQjEGyxxUHHASy/l092Ge7v8+I3sWb6f7tD+nrVasd3p6L82tQXIpniT2nSOOTWO
	gIZeSATZLh8Kw/nkzKAdzQwFMULTUO7mfODiTlvMQismhojt8OFMIw699JWRn5Zzp00MNq9dAbZ
	L1KSTW3LY0i3BbOa1N34iDDTy7Q8dcpq/vFpiN3ELf63yF3j9GObrMjjNLcrcPhxFNyytWLrF7l
	Os36JA==
X-Received: by 2002:a05:600c:4e8e:b0:483:c35d:3659 with SMTP id
 5b1f17b1804b1-486fee04a48mr53945845e9.18.1774026281186; Fri, 20 Mar 2026
 10:04:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223224617.GA2390314@frogsfrogsfrogs> <CAJnrk1Yd1J60-Ek=O7jzZQg454pbr3O=b71yZHzYbrWfqJr__w@mail.gmail.com>
 <20260316180408.GN6069@frogsfrogsfrogs> <CAJnrk1bmJYMt27xedN2Xza0KPXfYEbh-9g=3fNWru-HRM9WFEw@mail.gmail.com>
 <20260316234137.GJ1742010@frogsfrogsfrogs> <208bfbd2-d671-462c-925f-4d51b7df1f18@gmail.com>
 <20260318213129.GB6004@frogsfrogsfrogs> <c7866006-bd17-4fd8-a603-bd3016fdfeb0@gmail.com>
 <20260319160836.GC6004@frogsfrogsfrogs>
In-Reply-To: <20260319160836.GC6004@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 20 Mar 2026 10:04:29 -0700
X-Gm-Features: AaiRm50xHe4ukUSm2hvSegIf78mKkgxNJHj63lsspClyd3AiJBMTgrgezTnWrb0
Message-ID: <CAJnrk1Zpxv1CyUn2sbN2j73M57F8r4foyDQQ0Df_g0Ev+yx-Qg@mail.gmail.com>
Subject: Re: [PATCHBLIZZARD v7] fuse/libfuse/e2fsprogs: containerize ext4 for
 safer operation
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Demi Marie Obenour <demiobenour@gmail.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	bpf@vger.kernel.org, linux-ext4 <linux-ext4@vger.kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bernd@bsbernd.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	Neal Gompa <neal@gompa.dev>, Amir Goldstein <amir73il@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, John@groves.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 9:08=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Thu, Mar 19, 2026 at 03:28:21AM -0400, Demi Marie Obenour wrote:
> > On 3/18/26 17:31, Darrick J. Wong wrote:
> > > On Mon, Mar 16, 2026 at 08:20:29PM -0400, Demi Marie Obenour wrote:
> > >> On 3/16/26 19:41, Darrick J. Wong wrote:
> > >>> On Mon, Mar 16, 2026 at 04:08:55PM -0700, Joanne Koong wrote:
> > >>>> On Mon, Mar 16, 2026 at 11:04=E2=80=AFAM Darrick J. Wong <djwong@k=
ernel.org> wrote:
> > >>>>>
> > >>>>> On Mon, Mar 16, 2026 at 10:56:21AM -0700, Joanne Koong wrote:
> > >>>>>> On Mon, Feb 23, 2026 at 2:46=E2=80=AFPM Darrick J. Wong <djwong@=
kernel.org> wrote:
> > >>>>>>>
> > >>>>>>> There are some warts remaining:
> > >>>>>>>
> > >>>>>>> a. I would like to continue the discussion about how the design=
 review
> > >>>>>>>    of this code should be structured, and how might I go about =
creating
> > >>>>>>>    new userspace filesystem servers -- lightweight new ones bas=
ed off
> > >>>>>>>    the existing userspace tools?  Or by merging lklfuse?
> > >>>>>>
> > >>>>>> What do you mean by "merging lklfuse"?
> > >>>>>
> > >>>>> Merging the lklfuse project into upstream Linux, which involves r=
unning
> > >>>>> the whole kit and caboodle through our review process, and then f=
ixing
> > >>>>
> > >>>> Gotcha, so it would basically be having to port this arch/lkl
> > >>>> directory [1] into the linux tree
> > >>>
> > >>> Right.
> > >>>
> > >>>>> user-mode-linux to work anywhere other than x86.
> > >>>>
> > >>>> Are lklfuse and user-mode-linux (UML) two separate things or is
> > >>>> lklfuse dependent on user-mode-linux?
> > >>>
> > >>> I was under the impression that lklfuse uses UML.  Given the weird
> > >>> things in arch/lkl/Kconfig:
> > >>>
> > >>> config 64BIT
> > >>>   bool "64bit kernel"
> > >>>   default y if OUTPUT_FORMAT =3D "pe-x86-64"
> > >>>   default $(success,$(srctree)/arch/lkl/scripts/cc-objdump-file-for=
mat.sh|grep -q '^elf64-') if OUTPUT_FORMAT !=3D "pe-x86-64"
> > >>>
> > >>> I was kinda guessing x86_64 was the primary target of the developer=
s?
> > >>>
> > >>> /me notes that he's now looked into libguestfs per Demi Marie's com=
ments
> > >>> and some curiosity on the part of ngompa and i>
> > >>>
> > >>> Whatever it is that libguestfs does to stand up unprivileged fs mou=
nts
> > >>> also could fit this bill.  It's *really* slow to start because it t=
akes
> > >>> the booted kernel, creates a largeish initramfs, boots that combo v=
ia
> > >>> libvirt, and then fires up a fuse server to talk to the vm kernel.
> > >>>
> > >>> I think all you'd have to do is change libguestfs to start the VM a=
nd
> > >>> run the fuse server inside a systemd container instead of directly =
from
> > >>> the CLI.
> > >>
> > >> The feedback I have gotten from ngompa is that libguestfs is just
> > >> too slow for distros to use it to mount stuff.
> > >
> > > Yes, libguestfs is /verrrry/ slow to start up.
> > >
> > >>>>>> Could you explain what the limitations of lklfuse are compared t=
o the
> > >>>>>> fuse iomap approach in this patchset?
> > >>>>>
> > >>>>> The ones I know about are:
> > >>>>>
> > >>>>> 1> There's no support for vmapped kernel memory in UML mode, so a=
nyone
> > >>>>> who requires a large contiguous memory buffer cannot assemble the=
m out
> > >>>>> of "physical" pages.  This has been a stumbling block for XFS in =
the
> > >>>>> past.
> > >>>>>
> > >>>>> 2> LKLFUSE still uses the classic fuse IO paths, which means that=
 at
> > >>>>> best you can directio the IO through the lklfuse kernel.  At wors=
t you
> > >>>>> have to use the pagecache inside the lklfuse kernel, which is ver=
y
> > >>>>> wasteful.
> > >>>>
> > >>>> For the security / isolation use cases you've described, is
> > >>>> near-native performance a hard requirement?
> > >>>
> > >>> Not a hard requirement, just a means to convince people that they c=
an
> > >>> choose containment without completely collapsing performance.
> > >>>
> > >>>> As I understand it, the main use cases of this will be for mountin=
g
> > >>>> untrusted disk images and CI/filesystem testing, or are there broa=
der
> > >>>> use cases beyond this?
> > >>>
> > >>> That covers nearly all of it.
> > >>
> > >> It's worth noting that on ChromeOS and Android, the only trusted
> > >> disk images are those that are read-only and protected by dm-verity.
> > >> *Every* writable image is considered untrusted.
> > >>
> > >> I don't know if doing a full fsck at each boot is considered
> > >> acceptable, but I suspect it would slow boot far too much.
> > >
> > > Not to mention that an attacker who gained control of the boot proces=
s
> > > could inject malicious filesystem metadata after fsck completes
> > > successfully but before the kernel mount occurs.
> > >
> > >> Yes, Google ought to be paying for the kernel changes to fix this me=
ss.
> > >>
> > >>>>> 3> lklfuse hasn't been updated since 6.6.
> > >>>>
> > >>>> Gotcha. So if I'm understanding it correctly, the pros/cons come d=
own to:
> > >>>> lklfuse pros:
> > >>>> - (arguably) easier setup cost. once it's setup (assuming it's
> > >>>> possible to add support for the vmapped kernel memory thing you
> > >>>> mentioned above), it'll automatically work for every filesystem vs=
.
> > >>>> having to implement a fuse-iomap server for every filesystem
> > >>>
> > >>> Or even a good non-iomap fuse server for every filesystem.  Admitte=
dly
> > >>> the weak part of fuse4fs is that libext2fs is not as robust as the
> > >>> kernel is.
> > >>>
> > >>>> - easier to maintain vs. having to maintain each filesystem's
> > >>>> userspace server implementation
> > >>>
> > >>> Yeah.
> > >>>
> > >>>> lklfuse cons:
> > >>>> - worse (not sure by how much) performance
> > >>>
> > >>> Probably a lot, because now you have to run a full IO stack all the=
 way
> > >>> through lklfuse.
> > >>
> > >> How much is "a lot"?  Is it "this is only useful for non-interactive
> > >> overnight backups", "you will notice this in benchmarks but it's oka=
y
> > >> for normal use", or somewhere in between?
> > >
> > > Startup is painfully slow.  Normal operation isn't noticeably bad, bu=
t I
> > > didn't bother doing any performance comparisons.

For the CI/filesystem testing use case, could fork() help amortize
lklfuse's slow startup time? eg start lklfuse + pay LKL initialization
cost once, fork for each test, and each child mounts its own test
image?

> > >
> > >> Could lklfuse and iomap be combined?
> > >
> > > Probably, though you'd have to find a way to route the FUSE_IOMAP_*
> > > requests to a filesystem driver.  That's upside-down of the current
> > > iomap model where filesystems have to opt into using iomap on a
> > > per-IO-path basis, and then iomap calls the filesystem to find mappin=
gs.
> >
> > If it does get done it would be awesome.  I don't think I'll be able to
> > contribute, though.
>
> I wonder if one could export a (pnfs) layout from the lklfuse kernel to
> the real one, that's <cough> where struct iomap came from.  A huge
> downside to that solution is that layouts don't support out of place
> writes because pnfs doesn't support out of place writes.
>
> > >>>> - once it's merged into the kernel, we can't choose to not
> > >>>> maintain/support it in the future
> > >>>
> > >>> Correct.
> > >>>
> > >>>> Am I understanding this correctly?
> > >>>>
> > >>>> In my opinion, if near-native performance is not a hard requiremen=
t,
> > >>>> it seems like less pain overall to go with lklfuse. lklfuse seems =
a
> > >>>> lot easier to maintain and I'm not sure if some complexities like
> > >>>> btrfs's copy-on-write could be handled properly with fuse-iomap.
> > >>>
> > >>> btrfs cow can be done with iomap, at least on the directio end.  It=
's
> > >>> the other features like fsverity/fscrypt/data checksumming that are=
n't
> > >>> currently supported by iomap.
> > >>
> > >> Pretty much everyone on btrfs uses data checksumming.
> > >>
> > >>>> What are your thoughts on this?
> > >>>
> > >>> "Gee, what if I could simplify most of my own work out of existence=
?"
> > >>
> > >> What is that work?
> > >
> > > Everything I've put out since the end of online fsck for xfs.
> >
> > Is pretty much all of that work either on better FUSE performance or
> > fixes for problems found by fuzzers?
>
> Mostly the iomap parts of fuse-iomap.  It's a huge complication to add
> to the already confusing fuse codebase.

imo if you did end up going the lklfuse route, I think it'd still be
useful to have the generic iomap infrastructure pieces of your
fuse-iomap patchblizzard added, for future new filesystem
implementations that can provide extent mappings to get near-native IO
performance.

Thanks,
Joanne

>
> --D
