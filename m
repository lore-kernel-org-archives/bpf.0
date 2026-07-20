Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBF6445AF6
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 18:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784570785; cv=pass; b=tQTbMq49nz+uLP2+XyDSObZbKrrCMZF8UXVCxGcAKUF+7j4gjb7faymoLYd4hRvfV27Bdfq8u1FOrrBOuo9wegkuenj+rLNRrAA1Fio0xdEMILMAnu8ujuG1kRshnCML0nEBTYEVgGQ9ZL3KSyxIZ8GM8eBjlJowNN4HLPQLFzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784570785; c=relaxed/simple;
	bh=6sJy9PZJ/5uu+uq4/s91e/0S+srBf6fkJM0yl1tesOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LU8+GfLvczhAIoduD33peCR3VxL7+g78EyHV2A6nTwTrfkoERf7I7DYhYjwmBhKqcbvJ6vO0eo/bCN/XljihiiCAA3leFPm8WjQYHlaS/Z2bpWZ+9g+/Bxas0GgHPpInzn4jQWX1caWZsCiH2hZ9HNI+jXeeyb7LomFHLqzvKfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qVuGv4D9; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVuGv4D9"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-907ae240ac3so1248206d6.0
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 11:06:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784570782; cv=none;
        d=google.com; s=arc-20260327;
        b=BEoz/wil7zKovno/pmspqt2G9LbelQdvFq1ne876VeJviZxwTDa22ZS6yIt4l5XaMK
         d11GkqFOJE5iLvBaUCqlpxeEN6CgNaPOnujdEMX8qGTMPdb4W1rlMcRAFl2F5EGFQGCp
         tArrd7I2+jeJ0sj6iC1jDMRlzLNAwlva5n1lIh3MSVcgP+tnbpc2Vo/yIJpWTIS716yP
         GKZYTmE+Se/zbp9dQHG4qRl4o2VLcUs1zP50vERR80Z23HK+RGu3RVSD4KfOQR1nNp1D
         BJBeXhDcm/24KqcRkLowv69EMvaVkCphy0lMWxtCPM0FqQhaDQB0P8avyAoriWaZ8GDZ
         tMTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=erJxJKjIQYxuuAmQPSRTtK2LRA4+7u38hsE5ISZDX4o=;
        fh=fzL7MMXHmn7W3TsC8haAK7qpI9BdUCAVXUZ1OBT1Uz4=;
        b=K7hHM6Y9MRhkKjC3rF0sViI49GgieO8l1grTBcOxlazD5lNjnMFErqBdqRN4givIk5
         BM2vWXQHh5kdaR0m3Ha77i9QcYKaUpB8/tl/aArlQufhI72F0j8YUDBYmstWulKpgFgP
         iW5yT9+vldAZzzVHaDaxyhwBxZonynt6l41TBahV0nyrlRmCEaOZq5NggU+ZRdp9uS7K
         h6dm7JOIeUe5CS2JKEdth37Cj5F3dv12KCuYKELzTIK0Nmy9nUCm8dt3W/yh6xwErFwi
         5k5svFRRtQ3Iy5+vLA2enxHJkl8rFFGDCbXIgBQ2vLKU8M3/+5kW+Clr2RGpklaTnEcb
         uSow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784570782; x=1785175582; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=erJxJKjIQYxuuAmQPSRTtK2LRA4+7u38hsE5ISZDX4o=;
        b=qVuGv4D92AgPHJeaD8GZFiyzv+DT7Rd0tbKf9FpNpK9JWGWh8yNPZ+dDFAOJpgSQlf
         dKkN9HCTovfUqy5M/xL9HKeA4CTVm1ovHTIyUsA1AklqzmcsMZ1X8gz+isn+c+ZWvNWc
         y1h12Otum0BRnlX2KQ24j47IRyDiGGThUZbNz+aBVTEypmsZan1aTXjs4xSL4f6qpMJX
         bx6j3Dgjv6AnSRHoQhc9ufDQE3/BsFxokH9nK2DwRV8dE9WJYQAU18uTa+xQFLKAttqK
         yBtERcaagBEo8O0jmMC8JMB2v5xsws2OTAzXuO+A7xbna373zvvhR+GFxYCO4hkKD2nP
         hAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784570782; x=1785175582;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=erJxJKjIQYxuuAmQPSRTtK2LRA4+7u38hsE5ISZDX4o=;
        b=fkzKtFd5yFN3Y+NPwPAhEf6eVEnySMT/NdgxEkjSkbleHme0udgLQoJFZnXISxho8U
         57sCCSOexaGHs86U6jvT+KC7KS3OwsMePu5n/cDosco8atkoab0DBpp1NVEE3BQFE/gv
         luxzj6fCmocXCQyczJUv/d5GsBnhAwDxTd3bpvhgoJhj9aTlnaPq1NonZLZvDRq3GaJZ
         nh4ACMajFHqWxtRy0oevMWPjcXHOSDT2MEN+qrFbuJbXyAzt2MuhUrP4QCgivvwNOL41
         TJJmNyG2TvY0bz47vGLiJEcxfWmSx+ooquLxlMDXkr4LC9QlsdP6fuYCRYBo0YznRsEX
         1A8Q==
X-Forwarded-Encrypted: i=1; AHgh+RrylrtK8ZN072IXCbVyNgLXiDQbE78eS1vTwXjm9svxEFfFn4Z1DbD0L5vfVFrisMBrwgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyaP5FMcVriPXXiHcm1rzyHTvr21Rj423tABXOFdp12Rvd8cIR
	P4dFaFBeRADNZ2OUyGF3Ph5ATtWc/qA2EqD6Su+q9MwJaqYZLRTZflxYxUWkjpNKfYC7i72ZEaI
	4O3BTgA1x82y4pjCci39PB+ihnN2Arsc=
X-Gm-Gg: AR+sD126zTpAsVSwHs7oANTFdYTbhLCWrqogBYqnyHXPO36BjB7IeVupHBut4kAfteB
	M9ZisWD8NGvmO/fTA8keuhFLTBRGNy2OGWiFGPwRRCob/eDxPhEbLMSQDA/3KYE9s4mc3EmI1YE
	dRflUqHMNiKqg12PpNPBWwstFHxiOPuhvMk5HmqTBZffZW6dJ3B5oBmq2dXLuxK1c2cPdPL7SFO
	GywXLg97EEgmM4lgzfgym2n/t6RIfqj+PIOlkHpJZJ7bOGhRIcyZm3PPMWl5W8KOOBeRPf39ota
	DszawZIG0GZVQPjI
X-Received: by 2002:a05:6214:e45:b0:8ef:ddf7:3135 with SMTP id
 6a1803df08f44-907783b38cdmr173632066d6.38.1784570782095; Mon, 20 Jul 2026
 11:06:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708000956.46138-2-dwindsor@gmail.com> <cb9f84292a7f1d41ff8388d8c0c8c3d0@paul-moore.com>
In-Reply-To: <cb9f84292a7f1d41ff8388d8c0c8c3d0@paul-moore.com>
From: David Windsor <dwindsor@gmail.com>
Date: Mon, 20 Jul 2026 14:06:07 -0400
X-Gm-Features: AUfX_mxzIpBrzcPTV9KeowoimwOb7WQA9GzVVHyfVuwu0lx2Q8xYaxFF_5bIdv8
Message-ID: <CAEXv5_i_iHmF8n6Qf1NiVOhm2cCnVLgmwXK-b8M+hvmdO3aQdA@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] security: rework inode_init_security xattr handling
To: Paul Moore <paul@paul-moore.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 5:55=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> > +struct lsm_xattrs {
> > +     struct xattr *xattrs;
> > +     unsigned int xattr_count;
> > +};
>
> Please separate out the 'struct lsm_xattrs' related changes into a
> separate patch from the security_lsmxattr_add() changes.  I know they
> are related, but they are different things.
>

Will do.

> > +#ifdef CONFIG_BPF_LSM
> > +static unsigned int lsm_xattrs_used(const struct lsm_xattrs *xattrs,
> > +                                 const char *prefix)
> > +{
> > +     size_t prefix_len =3D strlen(prefix);
> > +     unsigned int i, n =3D 0;
> > +
> > +     for (i =3D 0; i < xattrs->xattr_count; i++) {
> > +             const char *name =3D xattrs->xattrs[i].name;
> > +
> > +             if (name && !strncmp(name, prefix, prefix_len))
> > +                     n++;
> > +     }
> > +     return n;
> > +}
> > +#endif /* CONFIG_BPF_LSM */
>
> More on this below, but this function isn't strictly BPF LSM related so
> let's drop the CONFIG_BPF_LSM macro bracketing.
>

Ack

> > +int security_lsmxattr_add(struct lsm_xattrs *xattrs, u64 lsm_id,
> > +                       const char *name, const void *value,
> > +                       size_t value_len)
> > +{
> > +     struct xattr *xattr;
> > +     void *xattr_value;
> > +     size_t name_len;
> > +
> > +     if (!xattrs || !xattrs->xattrs || !name || !value)
> > +             return -EINVAL;
>
> Sashiko raised a good point about xattrs->xattrs being NULL not
> necessarily being a good reason for -EINVAL.  If xattrs is NULL, yes,
> something has gone wrong and -EINVAL seems reasonable, but the
> xattr->xattrs NULL case does seem like it should simply return early
> with a value of 0 (see SELinux's handling of this case as an example).
>

The problem is, SELinux has already set the sid by before calling
lsm_get_xattr_slot, so we do indeed get an in-core label for the inode
before returning early here. Returning early here from BPF would not
mean the same thing: there is no label anywhere, in memory or on disk.

> > +     name_len =3D strlen(name);
> > +     if (name_len =3D=3D 0 || name_len > XATTR_NAME_MAX)
> > +             return -EINVAL;
> > +     if (value_len =3D=3D 0 || value_len > XATTR_SIZE_MAX)
> > +             return -EINVAL;
> > +
> > +     switch (lsm_id) {
> > +#ifdef CONFIG_BPF_LSM
> > +     case LSM_ID_BPF:
> > +             if (lsm_xattrs_used(xattrs, XATTR_BPF_LSM_SUFFIX) >=3D
> > +                 BPF_LSM_INODE_INIT_XATTRS)
> > +                     return -ENOSPC;
> > +             break;
> > +#endif /* CONFIG_BPF_LSM */
>
> I like to avoid macro conditional code inside functions whenever
> possible, and I think this is a case where we could avoid the conditional
> block with a little work.
>
> The LSM_ID_BPF macro is already defined as part of the UAPI so that will
> always be available.  While BPF_LSM_INODE_INIT_XATTRS is dependent on
> CONFIG_BPF_LSM in this revision, that should be easy enough to move
> outside the CONFIG_BPF_LSM conditional in bpf_lsm.h.  Eventually we
> should probably expand the lsm_id struct to carry this info, likely just
> a permanent/local copy of the LSM's lsm_blob_sizes passed during
> registration, but I can take care of that later; just make the
> BPF_LSM_INODE_INIT_XATTRS macro always accessible now.
>
> We should also probably record the xattr suffix/length when the LSM is
> registered, but that can also be done later with the other lsm_id
> additions.
>

Sounds good, will refactor to remove the conditional.

> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     /* Combine xattr value + name into one allocation. */
> > +     xattr_value =3D kmalloc(value_len + name_len + 1, GFP_NOWAIT);
> > +     if (!xattr_value)
> > +             return -ENOMEM;
> > +
> > +     memcpy(xattr_value, value, value_len);
> > +     memcpy(xattr_value + value_len, name, name_len);
> > +     ((char *)xattr_value)[value_len + name_len] =3D '\0';
>
> You'll need to add an additional memcpy() here, likely in a switch
> statement to handle the different LSMs, to copy over the LSM specific
> prefix.  It's a little ugly, but when we have things captured in the
> lsm_id struct it will get a lot cleaner.
>

Yup

>
> --
> paul-moore.com

Thanks,
David
