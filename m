Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6F91F03D7
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 20:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347821; cv=pass; b=WkEHsJTyyfoVUPgh5a3O/rR0yFCEMc8YvOPn5Y4UuVQLZzOaXZEuOsPT7GUzenWU7o2LMUUCEb4SxQq4ydPtGKalSUeKcetAZrAd01BWt+x2npkSWOjNfepsEE6A3ChAn3CjDiYO6I1IARq0JSsQbYLIhvfp+stdm3AR2DRMJYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347821; c=relaxed/simple;
	bh=OOvBZJ6WX5nPenvrSxxAaujAzbyOQcEkpqZQk83nV94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mwbI0dwHNKnA/f62a+8daQV7dJBBXk2CW//h7JHH4z39taLbywgFjM7fTUJNWsjSVa/zFeyPyX4RyXusw1AV//8/9LkX2Z6AKgkpcPqQ/RRHvWeS9H4bSjuY+Fe2Rv8lv5TsIfSQ15oL+X1Ujo4+ci5DIwOqQObmr7ECgwGnOEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=MehwFv4R; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="MehwFv4R"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-829b8b6c4d0so1235435b3a.0
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 13:37:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773347819; cv=none;
        d=google.com; s=arc-20240605;
        b=gua+OOA9VsJYXrgfUGOjhjG6MIse4ZyfxEkuFHVWLXlXYDt+hpzVfyZqEkvt8kod8u
         ZTxs3yTJVPHggbv/GDI2Qe7pWGuJTNNmQIzQYAi1rnemmyaolyE63TNrpHpv1rzSqU2V
         o5rYJHXVXq7gQGjoUJFOV/sLoyfFcwOFc999D+rOAYHUW0ixQIFDluAcLkJ8xsQkxeZq
         +p8yktRf9sq9it1PKOkYLBl3q8WmYzMcCC7f8qG5bEwBxpyjhUgroVOmN8L+zROQR9+W
         EPDgeKbIXKAZO7FUMciVZuZDQahJ83oPzgVujEe85XBm56yGhHw3COkJ8WCpU9iq8c/R
         0zNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kOgXOuABPdZLNyiApX2gyvIE8yNQYVfQVrD4AgpaeTk=;
        fh=wKl2YCORYg9+R/1UKWPh8YHNijqFiw6wTcYVlhgNzQM=;
        b=d27gQc/5DtmRIVxzxe2R8tIdnFeOq6j19c1nAH7sSxFpWZU08WVvijSCZs3JYwF8C+
         ycEEstMxSjmkd5ImmK+Tf4SDciYoWmchVCfeaE+/exG8q/mngf17i0EpjMCLKvXznzgs
         q5qZR+j88ouaqaAK/xjsqQdlGgfUk0o7/2ELQC4uDIDMJWV81sJavWrTtR5nQWBAh4rE
         tB+35Nl03yhmdIKl8gAlYNwD6OLxx59v/hM05qLeGnm5u54tdampIjZzpcH+aiBA621M
         kZ3h5EvnkiSP9nKudlOxHbD3gaPpjs6U3TG/jUVP63tg92uoGD6WiX20B0sVBcDNnnJG
         uYdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1773347819; x=1773952619; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kOgXOuABPdZLNyiApX2gyvIE8yNQYVfQVrD4AgpaeTk=;
        b=MehwFv4RidVHs10UnIxGQZjNQnUSX6Yb0SJ0w4+ilb4JZ+/hrq87cw8M9U5IiU67CA
         CUY3++bnzr3qv3oUB53BXT604Rgb8DFcW7lFKohc24lFcfWDosdU6+mYSABzdPhSGqwU
         bTX2vDS5wgFtDOiegOZzwY3QarSieNaye17Vdu6l4/0E4+E3IAefSTi8wAr35Z2ZCZ/D
         2w55U92CbROS6dWIMR3ySwvdnO3yanT61HixevPrmx/NKndU7ybI12UpcltdqOdNKARW
         5OXZqn2JsIMnRin8nhnpPME84GFyQZCYp9kaB45lwm8NQ2f0YTHmv80nJWVBuhE22A+k
         3+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773347819; x=1773952619;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOgXOuABPdZLNyiApX2gyvIE8yNQYVfQVrD4AgpaeTk=;
        b=ZrcF3j0Lp33E66GzIpXKIE8KpRC/XXFYoTF4Pf+RC0VbNJew72j5pBoKHWm67rPddc
         /pJ2Y4dbAvQW5vsKMRP7F8qcyefjQYgR7nE6LYR+ZZ7wsO9jEU+WEzQr4US/Sc9+o11r
         xy5MmrzpHUiQ/swpiW1RGOGSg3LknbMmehagnTH3yInRg21a7LdZra3wH5jzi1HMPKBW
         46ISJEZD+9zclAxLhIpCweT7Jh2nUtpxPYtCHW7OiZFL9+l5kyhTPMlrHZnm1heZOUvT
         j6xcBgncr+Dv7bhpZkXSTHroXX3Fl3x9B0m22Bb6vwpW4PLPVb9OiQjqD1sxbm88hRCP
         njsg==
X-Forwarded-Encrypted: i=1; AJvYcCWj9yOzu+oW9+ukMYM+LLfG0B4NwgFrpkZ0uYe8gGaXjpj30DcY6g8+EL3YjUcHaLJ0+t8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjR6NosMTHFzcUkww1LrA06tXyO3uGVDSQ0RawmvgK86V1AMkj
	TNyfXrBWEK4CZeHIk0it0DekbTjFoyPzbX+rz+KAQocRddvL2Syx/Y9fQsguwJJmeecUSQ4J6uh
	I9mmc/kAyH20Pdno9Nl6F5/FJ50CAj2UWZikEhQnk
X-Gm-Gg: ATEYQzzjx5mZXqPBMdSg6gtkQ1QmnRDZABsZsAMtWC/myeh8vdSTcj0Aw8eFiSnyobt
	H6X4ji/ZDL4wnkzjcO9LGxnRItCjShf8g4DrRaBgSjC3PQMizuOt83GWEclMCz7zliQUUCqqp8c
	zX8Am/bwCyRLQWnisI32nTA5SXmxyIUGqYXREn5TaelzE2M8gZcYlWX5AUUERA1jzjeEPKXk6JI
	k+xNf764yIBfjxleW2QAJ1BTPTjaWd04o+VVjxCyH3fOkYzRgQY8PzGF9zAE1DtZaRq3URuci46
	+sh2n3XTnhip/B4=
X-Received: by 2002:a05:6a00:4009:b0:82a:108b:80e3 with SMTP id
 d2e1a72fcca58-82a198d7123mr646639b3a.38.1773347819667; Thu, 12 Mar 2026
 13:36:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307212058.169511-1-jhs@mojatatu.com> <20260310184713.7e810431@kernel.org>
 <CAM0EoM=TAAfwZc3q1=RKWPrS778R_B8uM18ev_jYYz8oj4YiBA@mail.gmail.com> <20260311175249.54abe1b6@kernel.org>
In-Reply-To: <20260311175249.54abe1b6@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 12 Mar 2026 16:36:48 -0400
X-Gm-Features: AaiRm52Ay9btUcm8fjz-2e-6mv1j1MJyR1DhU8dho1U74A4Ifx5laPKTFvbVSqo
Message-ID: <CAM0EoMnv14pSaJWW3ZQuegkbQEqqye0zp0-_tCaOEWEg=C3xCQ@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: Mark qdisc for deletion if graft cannot delete
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, toke@toke.dk, 
	vinicius.gomes@intel.com, stephen@networkplumber.org, vladbu@nvidia.com, 
	cake@lists.bufferbloat.net, bpf@vger.kernel.org, ghandatmanas@gmail.com, 
	km.kim1503@gmail.com, security@kernel.org, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: multipart/mixed; boundary="000000000000dae71f064cd9b6e6"

--000000000000dae71f064cd9b6e6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 8:52=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 11 Mar 2026 12:22:41 -0400 Jamal Hadi Salim wrote:
> > > On Sat,  7 Mar 2026 16:20:58 -0500 Jamal Hadi Salim wrote:
> > > > Note: We tried a couple of different approaches that had smaller co=
de
> > > > footprint but were a bit fugly. The first approach was to use recur=
sion
> > > > on the qdisc hash table to iterate the descendants of the qdisc; ho=
wever,
> > > > the challenge here is if the graph depth is "high" - we may overflo=
w the
> > > > stack. The second approach was to use a breadth first search to ach=
ieve
> > > > the same goal; the challenge here was it was a quadratic algorithm.
> > >
> > > Lots of complexity when realistically only ingress/clsact support
> > > the unlocked operations. Can we not just take rtnl before the
> > > references and not bother all the real qdiscs with this @#%$ ?
> > > (diff just to illustrate the point not even compiled)
> >
> > Two of the several (I think 4!) patches we had took a similar path. I
> > am trying to remember at least one variant was bad for performance and
> > the other was unstable. Let's see if we can revive it and take a
> > closer look. BTW - none were pretty, it was maybe half the lines of
> > code but touched many things.
>
> FWIW / of course, we have to apply similar change to all(?) callers of
> __tcf_qdisc_find in cls_api. So LOC-wise it may end up also pretty long.
> And it's not going to help the already spaghetti-looking locking. But
> even if it's more LoC I quite like the idea of containing the poopy
> code to where problems originate which is the lockless filter handling.
> Fingers crossed..

Something like attached.
Unfortunately after running it for a few hours it reproduced.
The action code path (entered by virtue of filter code path execution)
releases the rtnl when attempting to load an action module. A parallel
qdisc operation waiting for the lock then grabs it and we hit the same
issue...

So now we have to be more invasive and start coordinating the action
code etc, which is not appealing. Thoughts?

cheers,
jamal

--000000000000dae71f064cd9b6e6
Content-Type: text/x-patch; charset="US-ASCII"; name="acquire_rtnl_before_qdisc_find.patch"
Content-Disposition: attachment; 
	filename="acquire_rtnl_before_qdisc_find.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mmnx66v11>
X-Attachment-Id: f_mmnx66v11

ZGlmZiAtLWdpdCBhL25ldC9zY2hlZC9jbHNfYXBpLmMgYi9uZXQvc2NoZWQvY2xzX2FwaS5jCmlu
ZGV4IDQ4MjljMjc0NDZlMy4uZWU1ZjZmZmY1N2NiIDEwMDY0NAotLS0gYS9uZXQvc2NoZWQvY2xz
X2FwaS5jCisrKyBiL25ldC9zY2hlZC9jbHNfYXBpLmMKQEAgLTM0OSw3ICszNDksNyBAQCBzdGF0
aWMgYm9vbCB0Y2ZfcHJvdG9fY2hlY2tfa2luZChzdHJ1Y3QgbmxhdHRyICpraW5kLCBjaGFyICpu
YW1lKQogCXJldHVybiBmYWxzZTsKIH0KIAotc3RhdGljIGJvb2wgdGNmX3Byb3RvX2lzX3VubG9j
a2VkKGNvbnN0IGNoYXIgKmtpbmQpCitzdGF0aWMgYm9vbCB0Y2ZfcHJvdG9faXNfdW5sb2NrZWQo
Y29uc3QgY2hhciAqa2luZCwgYm9vbCBydG5sX2hlbGQpCiB7CiAJY29uc3Qgc3RydWN0IHRjZl9w
cm90b19vcHMgKm9wczsKIAlib29sIHJldDsKQEAgLTM1Nyw3ICszNTcsNyBAQCBzdGF0aWMgYm9v
bCB0Y2ZfcHJvdG9faXNfdW5sb2NrZWQoY29uc3QgY2hhciAqa2luZCkKIAlpZiAoc3RybGVuKGtp
bmQpID09IDApCiAJCXJldHVybiBmYWxzZTsKIAotCW9wcyA9IHRjZl9wcm90b19sb29rdXBfb3Bz
KGtpbmQsIGZhbHNlLCBOVUxMKTsKKwlvcHMgPSB0Y2ZfcHJvdG9fbG9va3VwX29wcyhraW5kLCBy
dG5sX2hlbGQsIE5VTEwpOwogCS8qIE9uIGVycm9yIHJldHVybiBmYWxzZSB0byB0YWtlIHJ0bmwg
bG9jay4gUHJvdG8gbG9va3VwL2NyZWF0ZQogCSAqIGZ1bmN0aW9ucyB3aWxsIHBlcmZvcm0gbG9v
a3VwIGFnYWluIGFuZCBwcm9wZXJseSBoYW5kbGUgZXJyb3JzLgogCSAqLwpAQCAtMjIyOCw2ICsy
MjI4LDEyIEBAIHN0YXRpYyBib29sIGlzX3FkaXNjX2luZ3Jlc3MoX191MzIgY2xhc3NpZCkKIAly
ZXR1cm4gKFRDX0hfTUlOKGNsYXNzaWQpID09IFRDX0hfTUlOKFRDX0hfTUlOX0lOR1JFU1MpKTsK
IH0KIAorc3RhdGljIGJvb2wgcGFyZW50X2lzX2luZ3Jlc3Nfb3JfZWdyZXNzKF9fdTMyIHBhcmVu
dGlkKQoreworCXJldHVybiAoVENfSF9NQUtFKFRDX0hfQ0xTQUNULCBUQ19IX01JTl9JTkdSRVNT
KSA9PSBwYXJlbnRpZCkgfHwKKwkJKFRDX0hfTUFLRShUQ19IX0NMU0FDVCwgVENfSF9NSU5fRUdS
RVNTKSA9PSBwYXJlbnRpZCk7Cit9CisKIHN0YXRpYyBib29sIGlzX2luZ3Jlc3Nfb3JfY2xzYWN0
KHN0cnVjdCB0Y2ZfYmxvY2sgKmJsb2NrLCBzdHJ1Y3QgUWRpc2MgKnEpCiB7CiAJcmV0dXJuIHRj
Zl9ibG9ja19zaGFyZWQoYmxvY2spIHx8IChxICYmICEhKHEtPmZsYWdzICYgVENRX0ZfSU5HUkVT
UykpOwpAQCAtMjI1NSw2ICsyMjYxLDcgQEAgc3RhdGljIGludCB0Y19uZXdfdGZpbHRlcihzdHJ1
Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3Qgbmxtc2doZHIgKm4sCiAJaW50IGVycjsKIAlpbnQgdHBf
Y3JlYXRlZDsKIAlib29sIHJ0bmxfaGVsZCA9IGZhbHNlOworCWJvb2wgcHJvdG9faXNfdW5sb2Nr
ZWQ7CiAJdTMyIGZsYWdzOwogCiByZXBsYXk6CkBAIC0yMjg2LDI5ICsyMjkzLDM4IEBAIHN0YXRp
YyBpbnQgdGNfbmV3X3RmaWx0ZXIoc3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0IG5sbXNnaGRy
ICpuLAogCQkJcHJpb19hbGxvY2F0ZSA9IHRydWU7CiAJCX0gZWxzZSB7CiAJCQlOTF9TRVRfRVJS
X01TRyhleHRhY2ssICJJbnZhbGlkIGZpbHRlciBjb21tYW5kIHdpdGggcHJpb3JpdHkgb2YgemVy
byIpOworCQkJaWYgKHJ0bmxfaGVsZCkKKwkJCQlydG5sX3VubG9jaygpOwogCQkJcmV0dXJuIC1F
Tk9FTlQ7CiAJCX0KIAl9CiAKLQkvKiBGaW5kIGhlYWQgb2YgZmlsdGVyIGNoYWluLiAqLwotCi0J
ZXJyID0gX190Y2ZfcWRpc2NfZmluZChuZXQsICZxLCAmcGFyZW50LCB0LT50Y21faWZpbmRleCwg
ZmFsc2UsIGV4dGFjayk7Ci0JaWYgKGVycikKLQkJcmV0dXJuIGVycjsKLQogCWlmICh0Y2ZfcHJv
dG9fY2hlY2tfa2luZCh0Y2FbVENBX0tJTkRdLCBuYW1lKSkgewogCQlOTF9TRVRfRVJSX01TRyhl
eHRhY2ssICJTcGVjaWZpZWQgVEMgZmlsdGVyIG5hbWUgdG9vIGxvbmciKTsKLQkJZXJyID0gLUVJ
TlZBTDsKLQkJZ290byBlcnJvdXQ7CisJCWlmIChydG5sX2hlbGQpCisJCQlydG5sX3VubG9jaygp
OworCQlyZXR1cm4gLUVJTlZBTDsKIAl9CisJcHJvdG9faXNfdW5sb2NrZWQgPSB0Y2ZfcHJvdG9f
aXNfdW5sb2NrZWQobmFtZSwgcnRubF9oZWxkKTsKIAotCS8qIFRha2UgcnRubCBtdXRleCBpZiBy
dG5sX2hlbGQgd2FzIHNldCB0byB0cnVlIG9uIHByZXZpb3VzIGl0ZXJhdGlvbiwKLQkgKiBibG9j
ayBpcyBzaGFyZWQgKG5vIHFkaXNjIGZvdW5kKSwgcWRpc2MgaXMgbm90IHVubG9ja2VkLCBjbGFz
c2lmaWVyCi0JICogdHlwZSBpcyBub3Qgc3BlY2lmaWVkLCBjbGFzc2lmaWVyIGlzIG5vdCB1bmxv
Y2tlZC4KLQkgKi8KLQlpZiAocnRubF9oZWxkIHx8Ci0JICAgIChxICYmICEocS0+b3BzLT5jbF9v
cHMtPmZsYWdzICYgUURJU0NfQ0xBU1NfT1BTX0RPSVRfVU5MT0NLRUQpKSB8fAotCSAgICAhdGNm
X3Byb3RvX2lzX3VubG9ja2VkKG5hbWUpKSB7CisJaWYgKCFydG5sX2hlbGQgJiYgIXBhcmVudF9p
c19pbmdyZXNzX29yX2VncmVzcyhwYXJlbnQpKSB7CisJCXJ0bmxfaGVsZCA9IHRydWU7CisJCXJ0
bmxfbG9jaygpOworCX0KKworCS8qIEZpbmQgaGVhZCBvZiBmaWx0ZXIgY2hhaW4uICovCisJZXJy
ID0gX190Y2ZfcWRpc2NfZmluZChuZXQsICZxLCAmcGFyZW50LCB0LT50Y21faWZpbmRleCwgcnRu
bF9oZWxkLAorCQkJICAgICAgIGV4dGFjayk7CisJaWYgKGVycikgeworCQlpZiAocnRubF9oZWxk
KQorCQkJcnRubF91bmxvY2soKTsKKwkJcmV0dXJuIGVycjsKKwl9CisKKyAgICAgICAvKiBUYWtl
IHJ0bmwgbXV0ZXggaWYgY2xhc3NpZmllciB0eXBlIGlzIG5vdCBzcGVjaWZpZWQsIG9yIGNsYXNz
aWZpZXIKKwkqIGlzIG5vdCB1bmxvY2tlZC4KKwkqLworCWlmICghcnRubF9oZWxkICYmICFwcm90
b19pc191bmxvY2tlZCkgewogCQlydG5sX2hlbGQgPSB0cnVlOwogCQlydG5sX2xvY2soKTsKIAl9
CkBAIC0yNDUxLDE3ICsyNDY3LDIwIEBAIHN0YXRpYyBpbnQgdGNfbmV3X3RmaWx0ZXIoc3RydWN0
IHNrX2J1ZmYgKnNrYiwgc3RydWN0IG5sbXNnaGRyICpuLAogCX0KIAl0Y2ZfYmxvY2tfcmVsZWFz
ZShxLCBibG9jaywgcnRubF9oZWxkKTsKIAotCWlmIChydG5sX2hlbGQpCi0JCXJ0bmxfdW5sb2Nr
KCk7Ci0KIAlpZiAoZXJyID09IC1FQUdBSU4pIHsKIAkJLyogVGFrZSBydG5sIGxvY2sgaW4gY2Fz
ZSBFQUdBSU4gaXMgY2F1c2VkIGJ5IGNvbmN1cnJlbnQgZmx1c2gKIAkJICogb2YgdGFyZ2V0IGNo
YWluLgogCQkgKi8KKwkJaWYgKCFydG5sX2hlbGQpCisJCQlydG5sX2xvY2soKTsKIAkJcnRubF9o
ZWxkID0gdHJ1ZTsKIAkJLyogUmVwbGF5IHRoZSByZXF1ZXN0LiAqLwogCQlnb3RvIHJlcGxheTsK
IAl9CisKKwlpZiAocnRubF9oZWxkKQorCQlydG5sX3VubG9jaygpOworCiAJcmV0dXJuIGVycjsK
IAogZXJyb3V0X2xvY2tlZDoKQEAgLTI0ODgsNiArMjUwNyw3IEBAIHN0YXRpYyBpbnQgdGNfZGVs
X3RmaWx0ZXIoc3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0IG5sbXNnaGRyICpuLAogCXVuc2ln
bmVkIGxvbmcgY2wgPSAwOwogCXZvaWQgKmZoID0gTlVMTDsKIAlpbnQgZXJyOworCWJvb2wgcHJv
dG9faXNfdW5sb2NrZWQgPSB0cnVlOwogCWJvb2wgcnRubF9oZWxkID0gZmFsc2U7CiAKIAllcnIg
PSBubG1zZ19wYXJzZV9kZXByZWNhdGVkKG4sIHNpemVvZigqdCksIHRjYSwgVENBX01BWCwKQEAg
LTI1MDUsMjQgKzI1MjUsMjkgQEAgc3RhdGljIGludCB0Y19kZWxfdGZpbHRlcihzdHJ1Y3Qgc2tf
YnVmZiAqc2tiLCBzdHJ1Y3Qgbmxtc2doZHIgKm4sCiAJCXJldHVybiAtRU5PRU5UOwogCX0KIAot
CS8qIEZpbmQgaGVhZCBvZiBmaWx0ZXIgY2hhaW4uICovCi0KLQllcnIgPSBfX3RjZl9xZGlzY19m
aW5kKG5ldCwgJnEsICZwYXJlbnQsIHQtPnRjbV9pZmluZGV4LCBmYWxzZSwgZXh0YWNrKTsKLQlp
ZiAoZXJyKQotCQlyZXR1cm4gZXJyOwotCiAJaWYgKHRjZl9wcm90b19jaGVja19raW5kKHRjYVtU
Q0FfS0lORF0sIG5hbWUpKSB7CiAJCU5MX1NFVF9FUlJfTVNHKGV4dGFjaywgIlNwZWNpZmllZCBU
QyBmaWx0ZXIgbmFtZSB0b28gbG9uZyIpOwotCQllcnIgPSAtRUlOVkFMOwotCQlnb3RvIGVycm91
dDsKKwkJcmV0dXJuIC1FSU5WQUw7CisJfQorCXByb3RvX2lzX3VubG9ja2VkID0gdGNmX3Byb3Rv
X2lzX3VubG9ja2VkKG5hbWUsIHJ0bmxfaGVsZCk7CisKKwlpZiAoIXBhcmVudF9pc19pbmdyZXNz
X29yX2VncmVzcyhwYXJlbnQpKSB7CisJCXJ0bmxfaGVsZCA9IHRydWU7CisJCXJ0bmxfbG9jaygp
OworCX0KKworCS8qIEZpbmQgaGVhZCBvZiBmaWx0ZXIgY2hhaW4uICovCisJZXJyID0gX190Y2Zf
cWRpc2NfZmluZChuZXQsICZxLCAmcGFyZW50LCB0LT50Y21faWZpbmRleCwgcnRubF9oZWxkLAor
CQkJICAgICAgIGV4dGFjayk7CisJaWYgKGVycikgeworCQlpZiAocnRubF9oZWxkKQorCQkJcnRu
bF91bmxvY2soKTsKKwkJcmV0dXJuIGVycjsKIAl9Ci0JLyogVGFrZSBydG5sIG11dGV4IGlmIGZs
dXNoaW5nIHdob2xlIGNoYWluLCBibG9jayBpcyBzaGFyZWQgKG5vIHFkaXNjCi0JICogZm91bmQp
LCBxZGlzYyBpcyBub3QgdW5sb2NrZWQsIGNsYXNzaWZpZXIgdHlwZSBpcyBub3Qgc3BlY2lmaWVk
LAotCSAqIGNsYXNzaWZpZXIgaXMgbm90IHVubG9ja2VkLgorCS8qIFRha2UgcnRubCBtdXRleCBp
ZiBmbHVzaGluZyB3aG9sZSBjaGFpbiwgY2xhc3NpZmllciB0eXBlIGlzIG5vdAorCSAqIHNwZWNp
ZmllZCwgY2xhc3NpZmllciBpcyBub3QgdW5sb2NrZWQuCiAJICovCi0JaWYgKCFwcmlvIHx8Ci0J
ICAgIChxICYmICEocS0+b3BzLT5jbF9vcHMtPmZsYWdzICYgUURJU0NfQ0xBU1NfT1BTX0RPSVRf
VU5MT0NLRUQpKSB8fAotCSAgICAhdGNmX3Byb3RvX2lzX3VubG9ja2VkKG5hbWUpKSB7CisJaWYg
KCFydG5sX2hlbGQgJiYgKCFwcmlvIHx8ICFwcm90b19pc191bmxvY2tlZCkpIHsKIAkJcnRubF9o
ZWxkID0gdHJ1ZTsKIAkJcnRubF9sb2NrKCk7CiAJfQpAQCAtMjY0OCw2ICsyNjczLDcgQEAgc3Rh
dGljIGludCB0Y19nZXRfdGZpbHRlcihzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3Qgbmxtc2do
ZHIgKm4sCiAJdm9pZCAqZmggPSBOVUxMOwogCWludCBlcnI7CiAJYm9vbCBydG5sX2hlbGQgPSBm
YWxzZTsKKwlib29sIHByb3RvX2lzX3VubG9ja2VkOwogCiAJZXJyID0gbmxtc2dfcGFyc2VfZGVw
cmVjYXRlZChuLCBzaXplb2YoKnQpLCB0Y2EsIFRDQV9NQVgsCiAJCQkJICAgICBydG1fdGNhX3Bv
bGljeSwgZXh0YWNrKTsKQEAgLTI2NjQsMjMgKzI2OTAsMjkgQEAgc3RhdGljIGludCB0Y19nZXRf
dGZpbHRlcihzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3Qgbmxtc2doZHIgKm4sCiAJCXJldHVy
biAtRU5PRU5UOwogCX0KIAotCS8qIEZpbmQgaGVhZCBvZiBmaWx0ZXIgY2hhaW4uICovCi0KLQll
cnIgPSBfX3RjZl9xZGlzY19maW5kKG5ldCwgJnEsICZwYXJlbnQsIHQtPnRjbV9pZmluZGV4LCBm
YWxzZSwgZXh0YWNrKTsKLQlpZiAoZXJyKQotCQlyZXR1cm4gZXJyOwotCiAJaWYgKHRjZl9wcm90
b19jaGVja19raW5kKHRjYVtUQ0FfS0lORF0sIG5hbWUpKSB7CiAJCU5MX1NFVF9FUlJfTVNHKGV4
dGFjaywgIlNwZWNpZmllZCBUQyBmaWx0ZXIgbmFtZSB0b28gbG9uZyIpOwotCQllcnIgPSAtRUlO
VkFMOwotCQlnb3RvIGVycm91dDsKKwkJcmV0dXJuIC1FSU5WQUw7CiAJfQotCS8qIFRha2UgcnRu
bCBtdXRleCBpZiBibG9jayBpcyBzaGFyZWQgKG5vIHFkaXNjIGZvdW5kKSwgcWRpc2MgaXMgbm90
Ci0JICogdW5sb2NrZWQsIGNsYXNzaWZpZXIgdHlwZSBpcyBub3Qgc3BlY2lmaWVkLCBjbGFzc2lm
aWVyIGlzIG5vdAotCSAqIHVubG9ja2VkLgotCSAqLwotCWlmICgocSAmJiAhKHEtPm9wcy0+Y2xf
b3BzLT5mbGFncyAmIFFESVNDX0NMQVNTX09QU19ET0lUX1VOTE9DS0VEKSkgfHwKLQkgICAgIXRj
Zl9wcm90b19pc191bmxvY2tlZChuYW1lKSkgeworCXByb3RvX2lzX3VubG9ja2VkID0gdGNmX3By
b3RvX2lzX3VubG9ja2VkKG5hbWUsIGZhbHNlKTsKKworCWlmICghcGFyZW50X2lzX2luZ3Jlc3Nf
b3JfZWdyZXNzKHBhcmVudCkpIHsKKwkJcnRubF9oZWxkID0gdHJ1ZTsKKwkJcnRubF9sb2NrKCk7
CisJfQorCisJLyogRmluZCBoZWFkIG9mIGZpbHRlciBjaGFpbi4gKi8KKwllcnIgPSBfX3RjZl9x
ZGlzY19maW5kKG5ldCwgJnEsICZwYXJlbnQsIHQtPnRjbV9pZmluZGV4LCBydG5sX2hlbGQsCisJ
CQkgICAgICAgZXh0YWNrKTsKKwlpZiAoZXJyKSB7CisJCWlmIChydG5sX2hlbGQpCisJCQlydG5s
X3VubG9jaygpOworCQlyZXR1cm4gZXJyOworCX0KKyAgICAgICAvKiBUYWtlIHJ0bmwgbXV0ZXgg
aWYgY2xhc3NpZmllciB0eXBlIGlzIG5vdCBzcGVjaWZpZWQsIG9yIGNsYXNzaWZpZXIgaXMKKwkq
IG5vdCB1bmxvY2tlZC4KKwkqLworCWlmICghcnRubF9oZWxkICYmICFwcm90b19pc191bmxvY2tl
ZCkgewogCQlydG5sX2hlbGQgPSB0cnVlOwogCQlydG5sX2xvY2soKTsKIAl9Cg==
--000000000000dae71f064cd9b6e6--
